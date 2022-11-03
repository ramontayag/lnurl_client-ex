defmodule LnurlTest do
  use ExUnit.Case
  doctest Lnurl

  test "#decode handles non-lnurl strings" do
    assert Lnurl.decode("LNURLINVALID") ==
      {:error, "Unable to parse: no_seperator"}
  end
end
