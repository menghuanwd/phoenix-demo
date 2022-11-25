defmodule CreditStakeWeb.ArticleController do
  use CreditStakeWeb, :controller
  use PhoenixSwagger

  alias CreditStake.Database
  alias CreditStake.Database2
  alias CreditStake.Database.Article

  action_fallback CreditStakeWeb.FallbackController

  def swagger_definitions do
    %{
      BaiscArticle:
        swagger_schema do
          title("BaiscArticle")
          description("A article of the app")

          properties do
            id(:uuid, "Article ID")
            title(:string, "Article title", required: true)
            inserted_at(:string, "Creation timestamp", format: :datetime)
            updated_at(:string, "Update timestamp", format: :datetime)
          end

          example(%{
            id: "162bf201-55c9-4dff-81ec-4ac42288eb1e",
            title: "dave",
            link: "https://creditcard.cib.com.cn/promotion/national/",
	          content: "content",
	          published_at: "2022-11-17 05:10:56",
            inserted_at: "2022-11-17 05:10:56",
            updated_at: "2022-11-17 05:10:56"
          })
        end,
      Article:
        swagger_schema do
          title("Article")
          property(:data, Schema.ref(:BaiscArticle))
        end,
      Articles:
        swagger_schema do
          title("Articles")
          property(:data, Schema.array(:BaiscArticle))
        end
    }
  end

  swagger_path :index do
    tag("Articles")
    paging(size: "per", number: "page")
    summary("List Articles")
    description("List all articles in the database")
    produces("application/json")

    parameters do
    end

    response(200, "OK", Schema.ref(:Articles))
  end

  def index(conn, params) do
	  scrivener = Database2.all(Article, params)

    render(conn, "index.json", scrivener: scrivener)
  end

  swagger_path(:create) do
    tag("Articles")
    summary("Create article")
    description("Creates a new article")
    consumes("application/json")
    produces("application/json")

    parameter(:request_params, :body, Schema.ref(:BaiscArticle), "The article request params")

    response(201, "Article created OK", Schema.ref(:Article))
  end

  def create(conn, %{"article" => article_params}) do
    with {:ok, %Article{} = article} <- Database.create_article(article_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article)
    end
  end

  swagger_path :show do
    tag("Articles")
    summary("Show Article")
    description("show a new article")

    parameter(:id, :path, :uuid, "Article ID",
      required: true,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    produces("application/json")

    response(200, "Article OK", Schema.ref(:Article))
  end

  def show(conn, %{"id" => id}) do
    article = Database2.find(Article, id)
    render(conn, "show.json", article: article)
  end

  swagger_path :update do
    tag("Articles")
    summary("Update Article")
    description("Update a Article by UUID")
    consumes("application/json")
    produces("application/json")

    parameter(:id, :path, :uuid, "Article ID",
      required: true,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    parameter(:request_params, :body, Schema.ref(:BaiscArticle), "The article request params")

    response(200, "Article update OK", Schema.ref(:Article))
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Database.get_article!(id)

    with {:ok, %Article{} = article} <- Database.update_article(article, article_params) do
      render(conn, "show.json", article: article)
    end
  end

  swagger_path :delete do
    tag("Articles")
    summary("Delete Article")
    description("Delete a article by UUID")

    parameter(:id, :path, :uuid, "Article ID",
      required: true,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    response(204, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    article = Database.get_article!(id)

    with {:ok, %Article{}} <- Database.delete_article(article) do
      send_resp(conn, :no_content, "")
    end
  end
end
