defmodule Lnurl.MockServer do

  use Plug.Router

  plug Plug.Parsers, parsers: [:json],
                    pass:  ["text/*"],
                    json_decoder: Poison

  plug :match
  plug :dispatch

  get "/.well-known/lnurlp/successful-call" do
    body = %{
      "callback" => "https://api.url.com/api/v1/lnurl/payreq/33",
      "commentAllowed" => 32,
      "maxSendable" => 100000000000,
      "metadata" => "[[\"text/plain\",\"Pay to Wallet of Satoshi user: skilledcrawdad81\"],[\"text/identifier\",\"skilledcrawdad81@walletofsatoshi.com\"]]",
      "minSendable" => 1000,
      "tag" => "payRequest"
    }

    conn
    |> Plug.Conn.send_resp(200, Poison.encode!(body))
  end

end
