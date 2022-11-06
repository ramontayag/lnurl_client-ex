defmodule LightningAddressTest do

  use ExUnit.Case
  alias Lnurl.LightingAddress
  doctest LightingAddress

  describe "parse/1 given a lightning address" do
    test "it parses a lightning address string and returns a struct" do
      {:ok, lightning_address} = LightingAddress.parse("user@domain.com")

      assert lightning_address.username == "user"
      assert lightning_address.host == "domain.com"
    end
  end

  describe "parse/1 given a non-lightning address" do
    test "it returns an error" do
      {:error, reason} = LightingAddress.parse("https://hi.com")

      assert reason == "`https://hi.com` is not a Lightning Address"
    end
  end

  describe "convert_to_lnurl_pay_url/1 given localhost domain" do
    test "it converts the LightingAddress struct to an LNURL Pay URL using http scheme" do
      lightning_address = %LightingAddress{username: "j", host: "localhost:8080"}
      url = LightingAddress.convert_to_lnurl_pay_url(lightning_address)

      assert url == "http://localhost:8080/.well-known/lnurlp/j"
    end
  end

  describe "convert_to_lnurl_pay_url/1 given non-localhost domain" do
    test "it converts the LightingAddress struct to an LNURL Pay URL using https scheme" do
      lightning_address = %LightingAddress{username: "j", host: "g.com"}
      url = LightingAddress.convert_to_lnurl_pay_url(lightning_address)

      assert url == "https://g.com/.well-known/lnurlp/j"
    end
  end

end
