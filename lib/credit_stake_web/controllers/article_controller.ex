defmodule CreditStakeWeb.ArticleController do
  use CreditStakeWeb, :controller
  use PhoenixSwagger

  alias CreditStake.Repo
  alias CreditStake.Model.Article, as: Model
  alias CreditStake.Database.Article

  action_fallback CreditStakeWeb.FallbackController

  def swagger_definitions do
    %{
	    RequestArticle:
		    swagger_schema do
			    title("RequestArticle")
			    description("A article of the app")
			
			    properties do
				    title(:string, "Article title", required: true)
				    bank_id(:uuid, "Bank ID", required: true)
				    link(:string, "Article Link", required: true)
				    content(:string, "Article Content", required: true)
				    published_at(:string, "Article published at", required: true)
			    end
			
			    example(%{
				    bank_id: "088dfd10-855b-48fa-8d97-d687ec0f174a",
				    title: "dave",
				    link: "https://creditcard.cib.com.cn/promotion/national/",
				    published_at: "2022-11-17 05:10:56",
				    content: "content",
			    })
		    end,
      ResponseArticle:
        swagger_schema do
          title("ResponseArticle")
          description("A article of the app")

          properties do
            id(:uuid, "Article ID")
            bank_id(:uuid, "Bank ID")
            title(:string, "Article title", required: true)
            published_at(:string, "Article published at", required: true)
            created_at(:string, "Creation timestamp", format: :datetime)
            updated_at(:string, "Update timestamp", format: :datetime)
          end

          example(%{
            id: "162bf201-55c9-4dff-81ec-4ac42288eb1e",
            title: "dave",
            link: "https://creditcard.cib.com.cn/promotion/national/",
	          content: "content",
	          bank_id: "162bf201-55c9-4dff-81ec-4ac42288eb1e",
	          published_at: "2022-11-17 05:10:56",
            created_at: "2022-11-17 05:10:56",
            updated_at: "2022-11-17 05:10:56"
          })
        end,
      Article:
        swagger_schema do
          title("Article")
          property(:data, Schema.ref(:ResponseArticle))
        end,
      Articles:
        swagger_schema do
          title("Articles")
          property(:data, Schema.array(:ResponseArticle))
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
	  scrivener = Model.all(params)

    render(conn, "index.json", scrivener: scrivener)
  end

  swagger_path(:create) do
    tag("Articles")
    summary("Create article")
    description("Creates a new article")
    consumes("application/json")
    produces("application/json")

    parameter(:request_params, :body, Schema.ref(:RequestArticle), "The article request params")

    response(201, "Article created OK", Schema.ref(:Article))
  end

  def create(conn, params) do
    with {:ok, %Article{} = article} <- Model.create(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.article_path(conn, :show, article))
      |> render("show.json", article: article |> Repo.preload([:bank]))
    end
  end

  swagger_path :show do
    tag("Articles")
    summary("Show Article")
    description("show a new article")

    parameter(:id, :path, :uuid, "Article ID",
      required: false,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    produces("application/json")

    response(200, "Article OK", Schema.ref(:Article))
  end

  def show(conn, %{"id" => id}) do
    article = Model.find(id)
    render(conn, "show.json", article: article)
  end

  swagger_path :update do
    tag("Articles")
    summary("Update Article")
    description("Update a Article by UUID")
    consumes("application/json")
    produces("application/json")

    parameter(:id, :path, :uuid, "Article ID",
      required: false,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    parameter(:request_params, :body, Schema.ref(:RequestArticle), "The article request params")

    response(200, "Article update OK", Schema.ref(:Article))
  end

  def update(conn, params) do
    with {:ok, %Article{} = article} <- Model.update(params) do
      render(conn, "show.json", article: article)
    end
  end

  swagger_path :delete do
    tag("Articles")
    summary("Delete Article")
    description("Delete a article by UUID")

    parameter(:id, :path, :uuid, "Article ID",
      required: false,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    response(204, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Article{}} <- Model.destroy(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
