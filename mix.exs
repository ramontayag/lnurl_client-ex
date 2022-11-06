defmodule LnurlClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :lnurl_client,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: extra_applications(Mix.env),
      mod: {LnurlClient.Application, [env: Mix.env]},
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bech32, "~> 1.0"},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},
      {:plug_cowboy, "~> 2.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp extra_applications(:test) do
    extra_applications(:default) ++ [:cowboy, :plug]
  end

  defp extra_applications(_) do
    [:logger]
  end

end
