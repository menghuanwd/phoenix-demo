# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :credit_stake,
  ecto_repos: [CreditStake.Repo],
  generators: [binary_id: true]

config :credit_stake, CreditStake.Repo, migration_timestamps: [inserted_at: :created_at]

# Configures the endpoint
config :credit_stake, CreditStakeWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CreditStakeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CreditStake.PubSub,
  live_view: [signing_salt: "uyq6OR0O"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :credit_stake, CreditStake.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :credit_stake, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: CreditStakeWeb.Router
    ]
  }

config :phoenix_swagger, json_library: Jason

config :credit_stake, CreditStake.Scheduler,
  jobs: [
    # Every minute
    # 	       {"* * * * *",              {Crawler.CIB, :invoke, []}},
    # Runs every midnight:
    {"@daily", {Crawler.CIB.List, :invoke, []}},
    {"@daily", {Crawler.PSBC.List, :invoke, []}}
  ]

config :credit_stake, CreditStake.Scheduler, debug_logging: false

config :credit_stake, Oban,
  repo: CreditStake.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

# config :floki, :html_parser, Floki.HTMLParser.FastHtml

# config :credit_stake, CreditStake.Web.Endpoint, url: [host: "localhost"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
