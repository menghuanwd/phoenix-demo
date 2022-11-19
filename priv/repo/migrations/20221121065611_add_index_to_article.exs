defmodule CreditStake.Repo.Migrations.AddIndexToArticle do
  use Ecto.Migration

  def change do
	  create unique_index(:articles, [:bank_id, :title, :published_at])
#	  create index(:articles, [:bank_id, :title, :published_at], unique: true)
  end
end
