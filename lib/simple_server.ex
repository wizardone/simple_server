defmodule SimpleServer do

  use GenServer

  def init(state = %SimpleServer.SimpleConfig{}) do
    {:ok, state}
  end

  def start do
  end
end
