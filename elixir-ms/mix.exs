defmodule ElixirMs.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_ms,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: true,
      deps: deps(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirMs.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:finch, "~> 0.14"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:castore, "~> 0.1"},
      {:plug_cowboy, "~> 2.6"},
      {:jason, "~> 1.4"},
      {:plug_checkup, "~> 0.6.0"},
      {:poison, "~> 5.0"},
      {:cors_plug, "~> 3.0"},
      {:timex, "~> 3.7"},
      {:excoveralls, "~> 0.10", only: :test},
      {:ex_unit_sonarqube, "~> 0.1", only: :test},
    ]
  end
end
