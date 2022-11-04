defmodule Lnurl.PayData do
  defstruct [:callback, :max_sendable, :min_sendable, :metadata, :tag, :comment_allowed]

  require Logger

  def from_server(map) do
    remap = for {key, val} <- map, into: %{} do
      {String.to_existing_atom(Macro.underscore(key)), val}
    end

    struct(Lnurl.PayData, remap)
  end
end
