defmodule Allybot.MixProject do
  use Mix.Project

  def project do
    [
      app: :allybot,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MyBot, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      # Discord commands dep
      {:alchemy, "~> 0.7.0", hex: :discord_alchemy},
      # API call dep
      {:httpoison, "~> 1.8"},
      {:poison, "~> 4.0"},
      # number rounding dep
      {:decimal, "~> 1.2"},
      # database dep
      {:ecto_sql, "~> 3.0"},
      {:mariaex, "~>0.9"},
      {:myxql, "~> 0.4.0"}
    ]
  end
end
