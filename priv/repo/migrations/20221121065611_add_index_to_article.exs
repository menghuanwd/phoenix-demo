defmodule CreditStake.Repo.Migrations.AddIndexToArticle do
  use Ecto.Migration

  def change do
	  create unique_index(:articles, [:bank_id, :title, :published_at])
  end
end
