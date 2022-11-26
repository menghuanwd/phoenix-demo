defmodule CreditStakeWeb.Schema do
	use Absinthe.Schema
	
	import_types CreditStakeWeb.Schema.ArticleTypes
	import_types CreditStakeWeb.Schema.BankTypes
	
	alias CreditStakeWeb.Resolvers.Articles
	alias CreditStakeWeb.Resolvers.Banks
	
	query do
		@desc "Get all banks"
		field :banks, list_of(:bank) do
			resolve &Banks.all/3
		end
		
		@desc "Get bank by id"
		field :bank, :bank do
			arg :id, non_null(:id)
			resolve &Banks.find/3
		end
		
		@desc "Get all articles"
		field :articles, list_of(:article) do
			resolve &Articles.all/3
		end
		
		@desc "Get article by id"
		field :article, :article do
			arg :id, non_null(:id)
			resolve &Articles.find/3
		end
	
	end
	
	mutation do
		
		@desc "Create a article"
		field :create_article, :article do
			arg :title, non_null(:string)
			arg :published_at, :string
			
			resolve &Articles.all/0
		end
		
	end

end
