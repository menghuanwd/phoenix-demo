defmodule CreditStake.Repo do
  use Ecto.Repo,
    otp_app: :credit_stake,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
