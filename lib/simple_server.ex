defmodule SimpleServer do

  use GenServer

  def init(state = %{}) do
    {:ok, socket} = :gen_tcp.listen(4000, [:binary])
    IO.inspect("Opening tcp connection")
    start(socket)
    {:ok, state}
  end

  defp start(socket) do
    case :gen_tcp.accept(socket) do
      {:ok, socker} -> start(socket)
      {:error, error} -> IO.inspect(error)
    end
  end
end
