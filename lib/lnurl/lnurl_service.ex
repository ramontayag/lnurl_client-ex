defmodule Lnurl.LnurlService do
  alias Lnurl.PayData
  alias Lnurl.LnurlService.Behaviour
  alias Lnurl.LightingAddress
  @behaviour Behaviour

  @impl Behaviour
  def get_pay_data(str) do
    pay_data = str
               |> convert_to_lnurl_pay_url
               |> HTTPoison.get
               |> handle_response

    { :ok, pay_data }
  end

  defp handle_response({:ok, %{body: body}}) do
    body
    |> Poison.decode!
    |> PayData.from_server
  end

  defp convert_to_lnurl_pay_url(str) do
    case LightingAddress.parse(str) do
      { :ok, lightning_address = %LightingAddress{} } ->
        lightning_address |> LightingAddress.convert_to_lnurl_pay_url
      { :error, _reason } -> str
    end
  end

end
