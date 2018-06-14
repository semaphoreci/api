defmodule Secrets.Mixfile do
  use Mix.Project

  def project do
    [
      app: :secrets,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Secrets.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:grpc, github: "tony612/grpc-elixir"},
      {:protobuf, "~> 0.5.3"},
      {:cowboy, "~> 2.2.0"},
      {:watchman, github: "renderedtext/ex-watchman"},
      {:timex, "~> 3.1"},
      {:sentry, "~> 6.2.1"},
      {:cachex, "~> 3.0"}
    ]
  end
end
