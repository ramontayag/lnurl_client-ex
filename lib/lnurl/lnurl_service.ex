defmodule Lnurl.LnurlService do
  alias Lnurl.PayData
  alias Lnurl.LnurlService.Behaviour
  @behaviour Behaviour

  @impl Behaviour
  def get_pay_data(url) do
    url
    |> HTTPoison.get
    |> handle_response
  end

  defp handle_response({:ok, %{body: body}}) do
    body
    |> Poison.decode!
    |> PayData.from_server
  end

end
