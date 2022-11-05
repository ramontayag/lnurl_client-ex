defmodule LnurlServiceTest do

  alias Lnurl.LnurlService
  alias Lnurl.PayData
  use ExUnit.Case
  doctest LnurlService

  require Logger

  test "get_pay_data/1 returns %PayData" do
    received_pay_data = LnurlService.get_pay_data("http://localhost:8081/.well-known/lnurlp/successful-call")
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
