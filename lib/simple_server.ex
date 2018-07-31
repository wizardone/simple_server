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
    serve(client)
  end

  defp serve(socket) do
    socket
    |> read()
    |> write()

    serve(socket)
  end

  defp read(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    socket
  end

  defp write(socket) do
    :gen_tcp.send(socket, SimpleFormats.format_response())
  end
end
