defmodule CreditStake.Repo.Migrations.AddPublishAtToArticle do
  use Ecto.Migration

  def change do
	  alter table(:articles) do
		  add(:published_at, :utc_datetime)
		  add(:link, :string)
	  end
  end
end
