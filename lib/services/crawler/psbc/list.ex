defmodule Crawler.PSBC.List do
  @moduledoc """
  	邮储银行
	  Crawler.PSBC.List.invoke
  """
  import Ecto.Query

  use Timex

  alias Floki
  alias HTTPoison
  alias CreditStake.Repo
  alias CreditStake.Database.Article
  alias CreditStake.Database.Bank
  alias CreditStake.Database

  @domain "https://www.psbc.com/cn/grfw/xyk/tyhd/qgthhd/"
  @bank_name "邮储银行"

  def invoke do
    query = from b in Bank, where: b.name == "邮储银行"

    bank = Repo.one(query)

    list(bank)
  end

  defp list(bank) do
	  IO.puts bank.crawler_url
    res = HTTPoison.get!(bank.crawler_url)

    {:ok, document} = Floki.parse_document(res.body)

    dom_list = document |> Floki.find(".col_list") |> Floki.find("ul li")

    list =
      for dom <- dom_list do
        a = Floki.find(dom, "a")

        {
          a |> Floki.text() |> String.replace("\n", "") |> String.replace(" ", ""),
          "#{@domain}#{a |> Floki.attribute("href")}" |> String.replace("./", ""),
          dom |> Floki.find("span") |> Floki.text() |> Timex.parse!("%Y-%m-%d", :strftime)
        }
      end
      
      

    for {title, link, published_at} <- list do
      query = from b in Article, where: b.title == ^title and b.published_at == ^published_at

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

          {:ok, article} = Database.create_article(params)

          %{id: article.id} |> Crawler.PSBC.DetailWorker.new() |> Oban.insert()
      end
    end
  end
end
