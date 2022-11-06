defmodule LnurlClient.PayData do
  defstruct [:callback, :max_sendable, :min_sendable, :metadata, :tag, :comment_allowed]

  require Logger

  def parse(json) do
    map = Poison.decode!(json)

    remap = for {key, val} <- map, into: %{} do
      atom = convert_key(key)
      { atom, convert_value(atom, val) }
    end

    struct(LnurlClient.PayData, remap)
  end

  def callback_with_amount(pay_data, amount) do
    query = %{amount: amount} |> URI.encode_query

    pay_data.callback
    |> URI.parse
    |> URI.append_query(query)
    |> URI.to_string
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
