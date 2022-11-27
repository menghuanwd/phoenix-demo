defmodule CreditStakeWeb.Resolvers.Articles do
	
	alias CreditStake.Database.Article
	alias CreditStake.Model.Article, as: Model
	
	def all(%Article{}=bank, _args, _resolution) do
		{:ok, Model.all(%{bank: bank}).entries}
	end
	
	def all(_parent, _args, _resolution) do
		{:ok, Model.all(%{}).entries}
	end
	
	def find(_parent, %{id: id}, _resolution) do
		case Model.find(id) do
			nil ->
				{:error, "Article ID #{id} not found"}
			
			article ->
				{:ok, article}
		end
	end
end
