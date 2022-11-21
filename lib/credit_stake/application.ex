defmodule CreditStake.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CreditStake.Repo,
      # Start the Telemetry supervisor
      CreditStakeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CreditStake.PubSub},
      # Start the Endpoint (http/https)
      CreditStakeWeb.Endpoint,
	
	    CreditStake.Scheduler,
	
	    {Oban, Application.fetch_env!(:credit_stake, Oban)}
      # Start a worker by calling: CreditStake.Worker.start_link(arg)
      # {CreditStake.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CreditStake.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CreditStakeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
