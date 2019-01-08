defmodule Sky.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sky,
      version: "0.0.1",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Sky.Application, []},
      extra_applications: [:logger, :runtime_tools, :redix]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:ecto_sql, "~> 3.0.3"},
      {:mariaex, ">= 0.9.1"},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:gettext, "~> 0.15"},
      {:plug_cowboy, "~> 2.0"},
      {:plug, "~> 1.7"},
      {:comeonin, "~> 4.1"},
      {:bcrypt_elixir, "~> 1.0"},
      {:timex, "~> 3.3"},
      # 上传图片
      {:arc, "~> 0.11.0"},
      {:arc_ecto, "~> 0.11.1"},
      # redis
      {:redix, "~> 0.7.0"},
      # json web token
      {:joken, "~> 1.4.1"},
      {:poison, "~> 3.1"},
      {:html_sanitize_ex, "~> 1.3"}
      # 分页
      # {:scrivener_ecto, "~> 1.2.2"},
      # {:scrivener_html, "~> 1.7"},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
