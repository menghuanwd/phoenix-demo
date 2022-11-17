defmodule CreditStake.Database.Article do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias CreditStake.Database.Bank

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "articles" do
    field :content, :string
    field :summary, :string
    field :title, :string
    field :visits, :integer
    
    timestamps()

    belongs_to :bank, Bank
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :summary, :content, :visits])
    |> validate_required([:title, :summary, :content, :visits])
  end
end
