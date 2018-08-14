defmodule SimpleServer do

  @options [:binary, packet: :line, active: false, reuseaddr: true]

  def init(state = %{}) do
    {:ok, socket} = :gen_tcp.listen(4000, @options)
    pid = spawn(fn -> loop(socket) end)
    {:ok, pid}
  end

  defp loop(socket) do
    IO.puts('Looping')
    {:ok, client} = :gen_tcp.accept(socket)
    Task.async(fn -> serve(client) end)
    loop(socket)
  end

  defp serve(socket) do
    IO.inspect(self())
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
