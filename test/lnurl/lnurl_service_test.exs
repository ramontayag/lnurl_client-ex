defmodule LnurlServiceTest do

  alias Lnurl.LnurlService
  alias Lnurl.PayData
  use ExUnit.Case
  doctest LnurlService

  require Logger

  describe "#get_pay_data/1 given LNURL Pay URL" do
    test "returns %PayData" do
      { :ok, received_pay_data } =
        LnurlService.get_pay_data("http://localhost:8081/.well-known/lnurlp/username")

      expected_pay_data = %PayData{
        callback: "http://localhost:8081/api/v1/lnurl/payreq/33",
        comment_allowed: 32,
        max_sendable: 100000000000,
        metadata: [["text/plain", "Pay to Wallet of Satoshi user: skilledcrawdad81"], ["text/identifier", "skilledcrawdad81@walletofsatoshi.com"]],
        min_sendable: 1000,
        tag: "payRequest"
      }

      assert received_pay_data == expected_pay_data
    end
  end

  describe "#get_pay_data/1 given a Lightning Address" do
    test "returns %PayData" do
      { :ok, received_pay_data } =
        LnurlService.get_pay_data("username@localhost:8081")

      expected_pay_data = %PayData{
        callback: "http://localhost:8081/api/v1/lnurl/payreq/33",
        comment_allowed: 32,
        max_sendable: 100000000000,
        metadata: [["text/plain", "Pay to Wallet of Satoshi user: skilledcrawdad81"], ["text/identifier", "skilledcrawdad81@walletofsatoshi.com"]],
        min_sendable: 1000,
        tag: "payRequest"
      }

      assert received_pay_data == expected_pay_data
    end
  end

end
