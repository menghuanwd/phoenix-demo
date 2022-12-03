import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :credit_stake, CreditStake.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "credit_stake_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  port: "5501",
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :credit_stake, CreditStakeWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "BiYpmMDAwKfEuRR+P0bu6wwgY1e9FW8La5PQzA9XYC7a6Hbn1lFJXkTEu9Zj+zeY",
  server: false

config :credit_stake, Oban, testing: :inline

# In test we don't send emails.
config :credit_stake, CreditStake.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
