defmodule SimpleServer do

  use GenServer

  @options [:binary, packet: :line, active: false, reuseaddr: true]

  def init(state) do
    {:ok, socket} = :gen_tcp.listen(4000, @options)
    loop_socket(socket)
    {:ok, state}
  end

  defp loop_socket(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    Task.async(fn -> serve(client) end)
    loop_socket(socket)
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
