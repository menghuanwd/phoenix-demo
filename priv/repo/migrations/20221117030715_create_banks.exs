defmodule CreditStake.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :crawler_url, :string

      timestamps()
    end

    create unique_index(:banks, [:name])
  end
end
