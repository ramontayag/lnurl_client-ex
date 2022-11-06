defmodule LnurlClient do
  alias LnurlClient.LnurlService

  @moduledoc """
  Documentation for `LnurlClient`.
  """

  @doc """
  Takes an LNURL string and decodes it.

  ## Examples

      iex> LnurlClient.decode("LNURL1DP68GURN8GHJ7UM9WFMXJCM99E3K7MF0V9CXJ0M385EKVCENXC6R2C35XVUKXEFCV5MKVV34X5EKZD3EV56NYD3HXQURZEPEXEJXXEPNXSCRVWFNV9NXZCN9XQ6XYEFHVGCXXCMYXYMNSERXFQ5FNS")
      {:ok, "https://service.com/api?q=3fc3645b439ce8e7f2553a69e5267081d96dcd340693afabe04be7b0ccd178df"}

  """
  def decode(str) do
    case Bech32.decode(str) do
      {:ok, "lnurl", url} -> {:ok, url}
      {:error, reason} -> { :error, "Unable to parse: #{reason}" }
    end
  end

  @doc """
  Takes an LNURL URL or Lightning Address to and returns the payment request details

  ## Examples

      iex> LnurlClient.get_pay_data("username@localhost:8081")
      {
        :ok,
        %LnurlClient.PayData{
          callback: "http://localhost:8081/api/v1/lnurl/payreq/33",
          comment_allowed: 32,
          max_sendable: 100000000000,
          metadata: [["text/plain", "Pay to Wallet of Satoshi user: skilledcrawdad81"], ["text/identifier", "skilledcrawdad81@walletofsatoshi.com"]],
          min_sendable: 1000,
          tag: "payRequest"
        }
      }

  """
  def get_pay_data(url) do
    LnurlService.get_pay_data(url)
  end

  @doc """
  Takes an LNURL URL or Lightning Address to and returns an %InvoiceResponse

  ## Examples

      iex> LnurlClient.create_invoice("username@localhost:8081", 10_000_000)
      { :ok, %LnurlClient.InvoiceResponse{pr: "lninvoice", routes: []} }
  """
  def create_invoice(str, amount) do
    LnurlService.create_invoice(str, amount)
  end
end
