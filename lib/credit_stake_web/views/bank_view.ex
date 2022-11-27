defmodule CreditStakeWeb.BankView do
  alias CreditStakeWeb.PaginationView
  use CreditStakeWeb, :view

  def render("index.json", %{scrivener: scrivener}) do
    PaginationView.pagination(scrivener, __MODULE__, "bank.json")
  end

  def render("show.json", %{bank: bank}) do
    %{data: render_one(bank, __MODULE__, "bank.json")}
  end

  def render("bank.json", %{bank: bank}) do
    %{
      id: bank.id,
      name: bank.name
    }
  end
end
