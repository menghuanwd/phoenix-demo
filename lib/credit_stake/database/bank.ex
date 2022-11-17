defmodule CreditStake.Database.Bank do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "banks" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
