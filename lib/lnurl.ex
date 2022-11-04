defmodule Lnurl do
  alias Lnurl.LnurlService

  @moduledoc """
  Documentation for `Lnurl`.
  """

  @doc """
  Takes an LNURL string and decodes it.

  ## Examples

      iex> Lnurl.decode("LNURL1DP68GURN8GHJ7UM9WFMXJCM99E3K7MF0V9CXJ0M385EKVCENXC6R2C35XVUKXEFCV5MKVV34X5EKZD3EV56NYD3HXQURZEPEXEJXXEPNXSCRVWFNV9NXZCN9XQ6XYEFHVGCXXCMYXYMNSERXFQ5FNS")
      {:ok, "https://service.com/api?q=3fc3645b439ce8e7f2553a69e5267081d96dcd340693afabe04be7b0ccd178df"}

  """
  def decode(str) do
    case Bech32.decode(str) do
      {:ok, "lnurl", url} -> {:ok, url}
      {:error, reason} -> { :error, "Unable to parse: #{reason}" }
    end
  end

  @doc """
  Takes an LNURL URL to and returns the payment request details
  """
  def get_pay_data(url) do
    LnurlService.get_pay_data(url)
  end
end
