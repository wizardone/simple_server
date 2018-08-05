defmodule SimpleServer do

  use GenServer

  def init(state = %{}) do
    {:ok, socket} = :gen_tcp.listen(4000, [:binary, packet: :line, active: false, reuseaddr: true])
    loop(socket)
    {:ok, state}
  end

  defp loop(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    IO.puts('Looping')
    Task.start_link(fn -> serve(client) end)
  end

  defp serve(socket) do
    {socket, data} = socket
                      |> read()
    write(socket, data)

    serve(socket)
  end

  defp read(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    {socket, data}
  end

  defp write(socket, response) do
    :gen_tcp.send(socket, SimpleFormats.format_response(response))
  end
end
