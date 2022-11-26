defmodule CreditStake.Database.Bank do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias CreditStake.Database.Article

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "banks" do
    field :name, :string
    field :crawler_url, :string

    timestamps(inserted_at: :created_at)
    
    has_many :articles, Article
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:name, :crawler_url])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
