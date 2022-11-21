defmodule CreditStakeWeb.BankController do
  use CreditStakeWeb, :controller
  use PhoenixSwagger

  alias CreditStake.Database
  alias CreditStake.Database.Bank

  action_fallback CreditStakeWeb.FallbackController

  def swagger_definitions do
    %{
      BaiscBank:
        swagger_schema do
          title("BaiscBank")
          description("A bank of the app")

          properties do
            id(:uuid, "Bank ID")
            name(:string, "Bank name", required: true)
            inserted_at(:string, "Creation timestamp", format: :datetime)
            updated_at(:string, "Update timestamp", format: :datetime)
          end

          example(%{
            id: "162bf201-55c9-4dff-81ec-4ac42288eb1e",
            name: "dave",
            crawler_url: "https://creditcard.cib.com.cn/promotion/national/",
            inserted_at: "2022-11-17 05:10:56",
            updated_at: "2022-11-17 05:10:56"
          })
        end,
      Bank:
        swagger_schema do
          title("Bank")
          property(:data, Schema.ref(:BaiscBank))
        end,
      Banks:
        swagger_schema do
          title("Banks")
          property(:data, Schema.array(:BaiscBank))
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

  def index(conn, _params) do
    banks = Database.list_banks()
    render(conn, "index.json", banks: banks)
  end

  swagger_path(:create) do
    tag("Banks")
    summary("Create bank")
    description("Creates a new bank")
    consumes("application/json")
    produces("application/json")

    parameter(:request_params, :body, Schema.ref(:BaiscBank), "The bank request params")

    response(201, "Bank created OK", Schema.ref(:Bank))
  end

  def create(conn, %{"bank" => bank_params}) do
    with {:ok, %Bank{} = bank} <- Database.create_bank(bank_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.bank_path(conn, :show, bank))
      |> render("show.json", bank: bank)
    end
  end

  swagger_path :show do
    tag("Banks")
    summary("Show Bank")
    description("show a new bank")

    parameter(:id, :path, :uuid, "Bank ID",
      required: true,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    produces("application/json")

    response(200, "Bank OK", Schema.ref(:Bank))
  end

  def show(conn, %{"id" => id}) do
    bank = Database.get_bank!(id)
    render(conn, "show.json", bank: bank)
  end

  swagger_path :update do
    tag("Banks")
    summary("Update Bank")
    description("Update a Bank by UUID")
    consumes("application/json")
    produces("application/json")

    parameter(:id, :path, :uuid, "Bank ID",
      required: true,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    parameter(:request_params, :body, Schema.ref(:BaiscBank), "The bank request params")

    response(200, "Bank update OK", Schema.ref(:Bank))
  end

  def update(conn, %{"id" => id, "bank" => bank_params}) do
    bank = Database.get_bank!(id)

    with {:ok, %Bank{} = bank} <- Database.update_bank(bank, bank_params) do
      render(conn, "show.json", bank: bank)
    end
  end

  swagger_path :delete do
    tag("Banks")
    summary("Delete Bank")
    description("Delete a bank by UUID")

    parameter(:id, :path, :uuid, "Bank ID",
      required: true,
      example: "162bf201-55c9-4dff-81ec-4ac42288eb1e"
    )

    response(204, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    bank = Database.get_bank!(id)

    with {:ok, %Bank{}} <- Database.delete_bank(bank) do
      send_resp(conn, :no_content, "")
    end
  end
end
