defmodule Foresight.MixProject do
  use Mix.Project

  def project do
    [
      app: :foresight,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Doc fields
      name: "Foresight",
      source_urL: "https://github.com/Simrayz/foresight",
      docs: [
        main: "Foresight"
      ]

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
      {:httpoison, "~> 1.6"},
      {:floki, "~> 0.29.0"},
      {:html5ever, "~> 0.8.0"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
