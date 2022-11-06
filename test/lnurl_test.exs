defmodule LnurlTest do
  use ExUnit.Case
  doctest Lnurl

  alias Lnurl.PayData

  test "#decode handles non-lnurl strings" do
    assert Lnurl.decode("LNURLINVALID") ==
      {:error, "Unable to parse: no_seperator"}
  end

  # TODO: avoid duplicate tests. LnurlService has the same one, but this is here because this is the public interface
  test "#get_pay_data/1 returns LNURL pay data" do
    { :ok, received_pay_data } = Lnurl.get_pay_data("http://localhost:8081/.well-known/lnurlp/username")
    expected_pay_data = %PayData{
      callback: "https://api.url.com/api/v1/lnurl/payreq/33",
      comment_allowed: 32,
      max_sendable: 100000000000,
      metadata: [["text/plain", "Pay to Wallet of Satoshi user: skilledcrawdad81"], ["text/identifier", "skilledcrawdad81@walletofsatoshi.com"]],
      min_sendable: 1000,
      tag: "payRequest"
    }

    assert received_pay_data == expected_pay_data
  end
end
