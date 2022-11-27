defmodule CreditStakeWeb.Schema.BankTypes do
  use Absinthe.Schema.Notation

  alias CreditStakeWeb.Resolvers

  @desc "bank fields"
  object :bank do
    field :id, non_null(:id), description: "UUID"
    field :name, non_null(:string)

    field :articles, list_of(:article) do
      resolve(&Resolvers.Article.all/3)
    end
  end
end
