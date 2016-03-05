use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :z_auth, ZAuth.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Set a higher stacktrace during test
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :z_auth, ZAuth.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "password",
  database: "z_auth_test1",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
