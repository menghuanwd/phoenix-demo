defmodule CreditStake.Repo do
  use Ecto.Repo,
    otp_app: :credit_stake,
    adapter: Ecto.Adapters.Postgres
end
