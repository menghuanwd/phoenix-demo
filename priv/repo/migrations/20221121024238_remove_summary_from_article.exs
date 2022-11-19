defmodule CreditStake.Repo.Migrations.RemoveSummaryFromArticle do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      remove(:summary, :text)
    end
  end
end
