defmodule CreditStakeWeb.Resolvers.Banks do
  alias CreditStake.Database.Bank
  alias CreditStake.Model.Bank, as: Model

  def all(_parent, args, _resolution) do
    # 	  resp = %{
    # 	    data: Model.all(%{}).entries
    # 	  }
    {:ok, Model.all(%{}).entries}
  end

  def find(_parent, %{id: id} = args, _resolution) do
    case Model.find(id) do
      nil ->
        {:error, "Bank ID #{id} not found"}

      bank ->
        {:ok, bank}
    end
  end

  def create(_parent, args, _resolution) do
	  case Model.create(args) do
		  {:ok, bank} -> {:ok, bank}
		  {:error, _} -> {:error, "Bank found"}
	  end
  end
end
