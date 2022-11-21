defmodule CreditStakeWeb.ArticleView do
  use CreditStakeWeb, :view
  alias CreditStakeWeb.ArticleView

  def render("index.json", %{scrivener: scrivener}) do
    %{
      data: render_many(scrivener.entries, ArticleView, "article.json"),
      meta: %{
        page_number: scrivener.page_number,
        page_size: scrivener.page_size,
        total_pages: scrivener.total_pages,
        total_entries: scrivener.total_entries
      }
    }
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, ArticleView, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
	    content: article.content
    }
  end
end
