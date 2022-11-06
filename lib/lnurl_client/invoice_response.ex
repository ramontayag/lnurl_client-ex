defmodule LnurlClient.InvoiceResponse do
  defstruct [:pr, :routes]
  alias LnurlClient.InvoiceResponse

  def parse(json) when is_binary(json) do
    { :ok, attrs } = Poison.decode(json)

    reattrs = for {key, val} <- attrs, into: %{} do
      atom = convert_key(key)
      { atom, val }
    end

    { :ok, struct(InvoiceResponse, reattrs) }
  end

  defp convert_key(key) when is_binary(key) do
    String.to_existing_atom(Macro.underscore(key))
  end

end
