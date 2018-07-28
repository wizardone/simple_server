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
    |> read_line()
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp write_line(line, socket) do
    :gen_tcp.send(socket, line)
  end
end
