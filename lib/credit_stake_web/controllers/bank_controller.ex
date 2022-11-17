defmodule CreditStakeWeb.BankController do
  use CreditStakeWeb, :controller

  alias CreditStake.Database
  alias CreditStake.Database.Bank

  action_fallback CreditStakeWeb.FallbackController

  def index(conn, _params) do
    banks = Database.list_banks()
    render(conn, "index.json", banks: banks)
  end

  def create(conn, %{"bank" => bank_params}) do
    with {:ok, %Bank{} = bank} <- Database.create_bank(bank_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bank_path(conn, :show, bank))
      |> render("show.json", bank: bank)
    end
  end

  def show(conn, %{"id" => id}) do
    bank = Database.get_bank!(id)
    render(conn, "show.json", bank: bank)
  end

  def update(conn, %{"id" => id, "bank" => bank_params}) do
    bank = Database.get_bank!(id)

    with {:ok, %Bank{} = bank} <- Database.update_bank(bank, bank_params) do
      render(conn, "show.json", bank: bank)
    end
  end

  def delete(conn, %{"id" => id}) do
    bank = Database.get_bank!(id)

    with {:ok, %Bank{}} <- Database.delete_bank(bank) do
      send_resp(conn, :no_content, "")
    end
  end
end
