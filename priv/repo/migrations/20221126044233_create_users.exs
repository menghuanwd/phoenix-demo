defmodule CreditStake.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nickname, :string, comment: "user's name"
      add :age, :integer

      timestamps()
    end
  end
end
