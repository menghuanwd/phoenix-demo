defmodule CreditStakeWeb.Resolvers.Banks do

  alias CreditStake.Repo
  alias CreditStake.Database2
  alias CreditStake.Database.Bank


#  def pagination(%{
#	  page_number: page,
#	  page_size: page_size,
#	  total_entries: total_count,
#	  total_pages: total_pages
#  }) do
#	  %{
#		  page: page,
#		  page_size: page_size,
#		  total_count: total_count,
#		  total_pages: total_pages
#	  }
#  end
  
  def all(_parent, args, _resolution) do
	  resp = %{
	    data: Database2.all(Bank, %{}).entries
	  }
    {:ok, resp}
  end

  def find(_parent, %{id: id}=args, _resolution) do
    case Database2.find(Bank, id) do
      nil ->
        {:error, "Bank ID #{id} not found"}

      bank ->
        {:ok, bank}
    end
  end
end
