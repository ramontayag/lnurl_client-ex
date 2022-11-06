defmodule LnurlClient.LnurlService do
  alias LnurlClient.PayData
  alias LnurlClient.LightingAddress
  alias LnurlClient.InvoiceResponse

  @spec get_pay_data(url :: String.t()) :: {:ok, %PayData{}}
  def get_pay_data(url_or_lightning_address) do
    response = url_or_lightning_address
               |> convert_to_lnurl_pay_url
               |> HTTPoison.get!
    pay_data = response.body |> PayData.parse

    { :ok, pay_data }
  end

  @spec create_invoice(String.t(), integer()) :: {atom(), any()}
  def create_invoice(url_or_lightning_address, amount) do
    { :ok, pay_data } = url_or_lightning_address |> get_pay_data

    PayData.callback_with_amount(pay_data, amount)
    |> get_invoice_response
  end

  defp convert_to_lnurl_pay_url(str) do
    case LightingAddress.parse(str) do
      { :ok, lightning_address = %LightingAddress{} } ->
        lightning_address |> LightingAddress.convert_to_lnurl_pay_url
      { :error, _reason } -> str
    end
  end

  defp get_invoice_response(url) do
    case HTTPoison.get(url) do
      {:ok, %{body: body}} -> InvoiceResponse.parse(body)
      {:error, reason} -> {:error, "unable to create invoice: #{reason}"}
    end
  end

end
