defmodule LnurlClient.InvoiceResponseTest do

  use ExUnit.Case
  alias LnurlClient.InvoiceResponse

  describe "parse/1 when json is given" do
    test "it parses the JSON and returns a InvoiceResponse struct" do
      { :ok, json } = Poison.encode(%{"pr" => "lninvoice", "routes" => []})
      { :ok, pay_response } = InvoiceResponse.parse(json)

      assert pay_response.pr == "lninvoice"
      assert pay_response.routes == []
    end
  end

end
