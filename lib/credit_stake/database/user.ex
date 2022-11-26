defmodule CreditStake.Database.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :age, :integer
    field :nickname, :string

    timestamps(inserted_at: :created_at)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nickname, :age])
    |> validate_required([:nickname, :age])
  end
end
