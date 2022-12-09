defmodule CreditStakeWeb.BankController do
  use CreditStakeWeb, :controller
  use CreditStakeWeb.BankSwagger

  alias CreditStake.Model.Bank, as: Model
  alias CreditStake.Database.Bank

  action_fallback CreditStakeWeb.FallbackController

  def index(conn, params) do
	  scrivener = Model.all(params)
	
	  render(conn, "index.json", scrivener: scrivener)
  end

  def create(conn, params) do
	  IO.inspect params
    with {:ok, %Bank{} = bank} <- Model.create(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bank_path(conn, :show, bank))
      |> render("show.json", bank: bank)
    end
  end

  def show(conn, %{"id" => id}) do
#    raise CreditStake.CustomError, "show my error"
    bank = Model.find(id)

    render(conn, "show.json", bank: bank)
  end

  def update(conn, params) do
    with {:ok, %Bank{} = bank} <- Model.update(params) do
      render(conn, "show.json", bank: bank)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Bank{}} <- Model.destroy(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
