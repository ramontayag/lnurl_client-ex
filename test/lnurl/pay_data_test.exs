defmodule Lnurl.PayData.Test do

  alias Lnurl.PayData

  use ExUnit.Case
  doctest PayData

  describe "from_server/1 when metadata is an escaped list" do
    test "takes parsed json from the server and returns a struct of PayData, parsing metadata again" do
      body = %{
        "callback" => "http://localhost:8081",
        "commentAllowed" => 32,
        "maxSendable" => 100000000000,
        "metadata" => "[[\"text/plain\",\"To user: abc\"],[\"text/identifier\",\"abc@url.com\"]]",
        "minSendable" => 1000,
        "tag" => "payRequest"
      }

      pay_data = PayData.from_server(body)

      assert pay_data.metadata == [
        ["text/plain", "To user: abc"],
        ["text/identifier", "abc@url.com"]
      ]
    end
  end

  describe "from_server/1 when metadata is not escaped" do
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
      }

      pay_data = PayData.from_server(body)

      assert pay_data.metadata == [
        ["text/plain", "To user: abc"],
        ["text/identifier", "abc@url.com"]
      ]
    end
  end

end
