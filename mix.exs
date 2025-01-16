defmodule Foresight.MixProject do
  use Mix.Project

  def project do
    [
      app: :foresight,
      version: "0.6.0",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      package: package(),
      # Doc fields
      name: "Foresight",
      description: "Web crawler to preview URLs",
      source_url: "https://github.com/Simrayz/foresight",
      docs: [
        main: "Foresight"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:floki, "~> 0.36.0"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      c: "compile"
    ]
  end

  defp package do
    [
      maintainers: ["Simrayz"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/Simrayz/foresight"}
    ]
  end
end
