defmodule SimpleServer do

  use GenServer

  @excluded_options [:port, :__struct__]

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

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
                     #IO.inspect(data)
    write(socket, data)

    serve(socket)
  end

  defp read(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} -> {socket, data}
      {:error, message} -> {socket, message}
    end
  end

  defp write(socket, response) do
    # TODO: Do we really need to patter match here. closed and enotconn
    # seem to be passed after the initial message
    case response do
      :closed -> nil
      :enotconn -> nil
      _ -> :gen_tcp.send(socket, SimpleFormats.format_response(response))
    end
  end

  defp format_config(state) do
    state
    |> Map.drop(@excluded_options)
    |> Map.to_list
  end
end
