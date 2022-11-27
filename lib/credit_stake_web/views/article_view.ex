defmodule CreditStakeWeb.ArticleView do
	alias CreditStakeWeb.PaginationView
  use CreditStakeWeb, :view

  def render("index.json", %{scrivener: scrivener}) do
	  PaginationView.pagination(scrivener, __MODULE__, "article.json")
  end

  def render("show.json", %{article: article}) do
    %{data: render_one(article, __MODULE__, "article.json")}
  end

  def render("article.json", %{article: article}) do
    %{
      id: article.id,
      title: article.title,
	    content: article.content,
	    published_at: article.published_at,
	    bank_name: article.bank.name,
    }
  end
end
