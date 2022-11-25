defmodule Crawler.PSBC.DetailWorker do
  use Oban.Worker

  alias Floki
  alias HTTPoison
  alias CreditStake.Database

  @impl true
  def perform(%{args: %{"id" => article_id}}) do
    article = Database.get_article!(article_id)
    res = HTTPoison.get!(article.link)
    #    res = HTTPoison.get!("https://www.psbc.com/cn/grfw/xyk/tyhd/qgthhd/202211/t20221102_187717.html")

    {:ok, document} = Floki.parse_document(res.body)

    content = document |> Floki.find(".trs_word") |> Floki.raw_html()

    Database.update_article(article, %{content: content})
  end
end
