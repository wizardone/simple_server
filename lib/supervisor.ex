defmodule SimpleServer do
  defmodule Supervisor do
    def start do
      children = [
        %{
          id: SimpleServer,
          start: {SimpleServer, :start_link, %SimpleConfig}
        }
      ]

      {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
    end
  end
end
