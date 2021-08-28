import Config

config :allybot, Allybot.Repo,
  database: "allybot_repo",
  username: "root",
  password: "william1023",
  hostname: "localhost"

config :allybot, ecto_repos: [Allybot.Repo]