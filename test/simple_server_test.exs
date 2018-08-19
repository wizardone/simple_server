defmodule SimpleServerTest do
  use ExUnit.Case
  doctest SimpleServer

  setup do
    {:ok, _pid} = GenServer.start_link(SimpleServer, %{})
    :ok
  end

  test "init" do
    assert GenServer.start_link(SimpleServer, %{}) == {:ok, ''}
  end
end
