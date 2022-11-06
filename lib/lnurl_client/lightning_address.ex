defmodule LnurlClient.LightingAddress do

  alias LnurlClient.LightingAddress
  defstruct [:username, :host]

  @lnurl_pay_path "/.well-known/lnurlp/:username"

  def parse(str) do
    case String.split(str, "@") do
      [username, host] -> { :ok, %LightingAddress{username: username, host: host} }
      [^str] -> { :error, "`#{str}` is not a Lightning Address" }
    end
  end

  def convert_to_lnurl_pay_url(%LightingAddress{username: username, host: host}) do
    uri = URI.parse("#{scheme_from(host)}://#{host}")
    %{uri | path: lnurl_pay_path(username)} |> URI.to_string
  end

  defp lnurl_pay_path(username) do
    String.replace(@lnurl_pay_path, ":username", username)
  end

  # This does not actually make a practical difference but the parsing library
  # thinks that the given string is the path when you don't supply the scheme.
  # URI does say that what it parses but be a well-formed URL.
  # Do this to avoid future breakage.
  defp scheme_from(host) do
    if String.contains?(host, "localhost") do
      "http"
    else
      "https"
    end
  end

end
