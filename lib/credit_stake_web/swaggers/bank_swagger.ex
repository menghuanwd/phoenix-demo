defmodule CreditStakeWeb.BankSwagger do
	use PhoenixSwagger
	
	defmacro __using__(opts) do
		quote do
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
			
			swagger_path(:create) do
				tag("Banks")
				summary("Create bank")
				description("Creates a new bank")
				consumes("application/json")
				produces("application/json")
				
				parameter(:request_params, :body, Schema.ref(:RequestBank), "The bank request params")
				
				response(201, "Bank created OK", Schema.ref(:Bank))
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
		end
	end
	
end
