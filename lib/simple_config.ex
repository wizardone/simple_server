defmodule SimpleConfig do
  defstruct port: 4000,
    packet: :line,
    active: false,
    reuseaddr: true,
    binary: true
end
