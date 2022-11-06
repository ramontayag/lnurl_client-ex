defmodule LnurlClient.PayData do
  defstruct [:callback, :max_sendable, :min_sendable, :metadata, :tag, :comment_allowed]

  require Logger

  def from_server(map) do
    remap = for {key, val} <- map, into: %{} do
      atom = convert_key(key)
      { atom, convert_value(atom, val) }
    end

    struct(LnurlClient.PayData, remap)
  end

  defp convert_key(key) when is_binary(key) do
    String.to_existing_atom(Macro.underscore(key))
  end

  defp convert_value(atom, val) when atom == :metadata do
    case Poison.decode(val) do
      { :ok, parsed } -> parsed
      { :error, _reason } -> val
    end
  end

  defp convert_value(_key, val), do: val
end
