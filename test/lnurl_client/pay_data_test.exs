defmodule LnurlClient.PayData.Test do

  alias LnurlClient.PayData

  use ExUnit.Case
  doctest PayData

  describe "parse/1 when metadata is an escaped list" do
    test "takes parsed json from the server and returns a struct of PayData, parsing metadata again" do
      body = %{
        "callback" => "http://localhost:8081",
        "commentAllowed" => 32,
        "maxSendable" => 100000000000,
        "metadata" => "[[\"text/plain\",\"To user: abc\"],[\"text/identifier\",\"abc@url.com\"]]",
        "minSendable" => 1000,
        "tag" => "payRequest"
      } |> Poison.encode!

      pay_data = PayData.parse(body)

      assert pay_data.metadata == [
        ["text/plain", "To user: abc"],
        ["text/identifier", "abc@url.com"]
      ]
    end
  end

  describe "parse/1 when metadata is not escaped" do
    test "takes parsed json from the server and returns a struct of PayData" do
      body = %{
        "callback" => "http://localhost:8081",
        "commentAllowed" => 32,
        "maxSendable" => 100000000000,
        "metadata" => [ [
          "text/plain", "To user: abc"],
          ["text/identifier", "abc@url.com"]
        ],
        "minSendable" => 1000,
        "tag" => "payRequest"
      } |> Poison.encode!

      pay_data = PayData.parse(body)

      assert pay_data.metadata == [
        ["text/plain", "To user: abc"],
        ["text/identifier", "abc@url.com"]
      ]
    end
  end

  describe "callback_with_amount/2" do
    test "it returns the callback url of the given pay_data with the amount" do
      pay_data = %PayData{callback: "https://a.com"}
      callback = PayData.callback_with_amount(pay_data, 200)

      assert callback == "https://a.com?amount=200"
    end
  end

end
