import Config

config :schematic, Schematic.Repo,
  database: "schematic_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :schematic,
  ecto_repos: [Schematic.Repo]
