defmodule CreditStakeWeb.Resolvers.Articles do
	
	alias CreditStake.Database.Article
	alias CreditStake.Database.Bank
	alias CreditStake.Database2
	
	def all(_parent, _args, _resolution) do
		{:ok, Database2.all(Article, %{}).entries}
	end
	
	def all(%Bank{}=bank, _args, _resolution) do
		{:ok, Database2.all(Article, %{bank: bank}).entries}
	end
	
	def find(_parent, %{id: id}=args, _resolution) do
		case Database2.find(Article, id) do
			nil ->
				{:error, "Article ID #{id} not found"}
			
			article ->
				{:ok, article}
		end
	end
end
