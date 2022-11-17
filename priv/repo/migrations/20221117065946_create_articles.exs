defmodule CreditStake.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :summary, :text
      add :content, :text
      add :visits, :integer, default: 0
      add :bank_id, references(:banks, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:articles, [:bank_id])
  end
end
