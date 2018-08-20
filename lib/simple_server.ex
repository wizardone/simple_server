defmodule SimpleServer do

  use GenServer

  @excluded_options [:port, :__struct__]

  def init(state = %SimpleConfig{}) do
    {:ok, socket} = :gen_tcp.listen(Map.get(state, :port), format_config(state))
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

  defp format_config(state) do
    state
    |> Map.drop(@excluded_options)
    |> Map.to_list
  end
end
