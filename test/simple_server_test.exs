defmodule SimpleServerTest do
  use ExUnit.Case
  doctest SimpleServer

  setup do
    {:ok, _pid} = GenServer.start_link(SimpleServer, %SimpleConfig{})
    :ok
  end

  test "init" do
  end
end
