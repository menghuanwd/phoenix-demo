defmodule Crawler.CIB.DetailWorker do
	use Oban.Worker
	
	alias Floki
	alias HTTPoison
	alias CreditStake.Database
	
	@impl true
	def perform(%{args: %{"id" => article_id}}) do
		article = Database.get_article!(article_id)
		res = HTTPoison.get!(article.link)
		#    res = HTTPoison.get!("https://creditcard.cib.com.cn/promotion/national/20220630_1.html")
		
		{:ok, document} = Floki.parse_document(res.body)
		
		content = document |> Floki.find(".pd20") |> Floki.raw_html()
		
		Database.update_article(article, %{content: content})
	end
end
