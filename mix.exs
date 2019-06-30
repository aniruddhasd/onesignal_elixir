defmodule OnesignalElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :onesignal_elixir,
      version: "0.1.6",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "Onesignal Elixir",
      source_url: "https://github.com/aniruddhasd/onesignal_elixir"
    ]
  end

  defp description do
    """
      This project is a wrapper for using the awesome Onesignal APIs. Currently supports Onesignal's Create Notification API.
    """
  end

  defp package do
    [
    files: ["lib", "mix.exs", "README.md"],
    maintainers: ["Aniruddha Deshpande"],
    licenses: ["Apache 2.0"],
    links: %{"GitHub" => "https://github.com/aniruddhasd/onesignal_elixir",
            "Docs" => "https://hexdocs.pm/onesignal_elixir"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false},
      {:httpoison, "~> 1.4"},
      {:poison, "~> 3.1"}
    ]
  end
  
end
