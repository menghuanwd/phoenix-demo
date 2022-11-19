defmodule Crawler.CIB do
  @moduledoc """
  	兴业银行
  """
  import Ecto.Query

  use Timex

  alias Floki
  alias HTTPoison
  alias CreditStake.Repo
  alias CreditStake.Database.Article
  alias CreditStake.Database.Bank
  alias CreditStake.Database

  @crawler_url "https://creditcard.cib.com.cn/promotion/national/"
  @domain "https://creditcard.cib.com.cn"
  @bank_name "兴业银行"

  def invoke do
    query = from b in Bank, where: b.name == @bank_name
    #    query = from b in Bank, where: b.name == "兴业银行"
    bank = Repo.one(query)

    list(bank)
  end

  defp list(bank) do
    res = HTTPoison.get!(bank.crawler_url)

    {:ok, document} = Floki.parse_document(res.body)

    dom_list = document |> Floki.find(".list") |> Floki.find("ul li")

    list =
      for dom <- dom_list do
        a = Floki.find(dom, "a")

        {
          a |> Floki.text() |> String.replace("\n", "") |> String.replace(" ", ""),
          "#{@domain}#{a |> Floki.attribute("href")}",
          dom |> Floki.find("span") |> Floki.text() |> Timex.parse!("%Y-%m-%d", :strftime)
        }
      end

    for {title, link, published_at} <- list do
      query = from b in Article, where: b.title == ^title and b.published_at == ^published_at
      
      {:ok, article} =
        case Repo.one(query) do
          %Article{} = article ->
            {:ok, article}

          nil ->
	          params = %{
		          title: title,
		          link: link,
		          published_at: published_at,
		          bank_id: bank.id
	          }
            Database.create_article(params)
        end

      detail(article)
    end
  end

  defp detail(article) do
    res = HTTPoison.get!(article.link)
    #    res = HTTPoison.get!("https://creditcard.cib.com.cn/promotion/national/20220630_1.html")

    {:ok, document} = Floki.parse_document(res.body)

    content = document |> Floki.find(".pd20") |> Floki.raw_html()

    Database.update_article(article, %{content: content})
  end
end
