defmodule Lnurl.LnurlService.Behaviour do
  alias Lnurl.PayData

  @callback get_pay_data(url :: String.t()) :: {:ok, %PayData{}}
end
