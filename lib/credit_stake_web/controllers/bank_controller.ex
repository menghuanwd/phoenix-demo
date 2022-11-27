defmodule CreditStakeWeb.BankController do
  use CreditStakeWeb, :controller
  use PhoenixSwagger

  alias CreditStake.Database
  alias CreditStake.Model.Bank, as: Model
  alias CreditStake.Database.Bank

  action_fallback CreditStakeWeb.FallbackController

  def swagger_definitions do
    %{
	    RequestBank:
		    swagger_schema do
			    title("RequestBank")
			    description("RequestBank")
			
			    properties do
				    name(:string, "Bank name", required: true)
				    crawler_url(:string, "Crawler Url", required: true)
			    end
			
			    example(%{
				    name: "dave",
				    crawler_url: "https://creditcard.cib.com.cn/promotion/national/",
			    })
	    end,
      ResponseBank:
        swagger_schema do
          title("ResponseBank")
          description("A bank of the app")

          properties do
            id(:uuid, "Bank ID")
            name(:string, "Bank name", required: true)
            created_at(:string, "Creation timestamp", format: :datetime)
            updated_at(:string, "Update timestamp", format: :datetime)
          end

          example(%{
            id: "162bf201-55c9-4dff-81ec-4ac42288eb1e",
            name: "dave",
            crawler_url: "https://creditcard.cib.com.cn/promotion/national/",
            created_at: "2022-11-17 05:10:56",
            updated_at: "2022-11-17 05:10:56"
          })
        end,
      Bank:
        swagger_schema do
          title("Bank")
          property(:data, Schema.ref(:ResponseBank))
        end,
      Banks:
        swagger_schema do
          title("Banks")
          property(:data, Schema.array(:ResponseBank))
        end
    }
  end

  swagger_path :index do
    tag("Banks")
    paging(size: "per", number: "page")
    summary("List Banks")
    description("List all banks in the database")
    produces("application/json")

    parameters do
    end

    response(200, "OK", Schema.ref(:Banks))
  end

  def index(conn, params) do
	  scrivener = Model.all(params)
	
	  render(conn, "index.json", scrivener: scrivener)
  end

  swagger_path(:create) do
    tag("Banks")
    summary("Create bank")
    description("Creates a new bank")
    consumes("application/json")
    produces("application/json")

    parameter(:request_params, :body, Schema.ref(:RequestBank), "The bank request params")

    response(201, "Bank created OK", Schema.ref(:Bank))
  end

  def create(conn, params) do
    with {:ok, %Bank{} = bank} <- Model.create(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bank_path(conn, :show, bank))
      |> render("show.json", bank: bank)
    end
  end

  swagger_path :show do
    tag("Banks")
    summary("Show Bank")
    description("show a bank")

    parameter(:id, :path, :uuid, "Bank ID",
      required: false,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    produces("application/json")

    response(200, "Bank OK", Schema.ref(:Bank))
  end

  def show(conn, %{"id" => id}) do
    bank = Model.find(id)

    render(conn, "show.json", bank: bank)
  end

  swagger_path :update do
    tag("Banks")
    summary("Update Bank")
    description("Update a Bank by UUID")
    consumes("application/json")
    produces("application/json")

    parameter(:id, :path, :uuid, "Bank ID",
      required: false,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    parameter(:request_params, :body, Schema.ref(:RequestBank), "The bank request params")

    response(200, "Bank update OK", Schema.ref(:Bank))
  end

  def update(conn, params) do
    with {:ok, %Bank{} = bank} <- Model.update(params) do
      render(conn, "show.json", bank: bank)
    end
  end

  swagger_path :delete do
    tag("Banks")
    summary("Delete Bank")
    description("Delete a bank by UUID")

    parameter(:id, :path, :uuid, "Bank ID",
      required: false,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    response(204, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Bank{}} <- Model.destroy(id) do
      send_resp(conn, :no_content, "")
    end
  end
end
