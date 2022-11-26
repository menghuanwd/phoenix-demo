defmodule CreditStakeWeb.Schema.ArticleTypes do
	use Absinthe.Schema.Notation
	
	alias CreditStakeWeb.Resolvers
	
	@desc "article fields"
	object :article do
		field :id, :id, description: "UUID"
		field :title, :string
		field :content, :string
		field :published_at, :string
#		field :bank, :bank2 do
#			resolve &Resolvers.Bank.find/1
#		end
	end
end
