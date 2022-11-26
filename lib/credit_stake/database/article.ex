defmodule CreditStake.Database.Article do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias CreditStake.Database.Bank

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :content, :string
    field :title, :string
    field :published_at, :utc_datetime
    field :link, :string
    field :visits, :integer

    timestamps(inserted_at: :created_at)

    belongs_to :bank, Bank
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :content, :visits, :published_at, :link, :bank_id])
    |> validate_required([:title, :published_at, :link, :bank_id])
  end
end
