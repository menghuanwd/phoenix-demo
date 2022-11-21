defmodule CreditStake.Database2 do
  @moduledoc """
  The Database2 context.
  """

  import Ecto.Query, warn: false
  alias CreditStake.Repo

  def all(klass, query) do
    from(p in klass, order_by: [asc: p.id])
    |> Repo.paginate(page: query["page"], page_size: query["per"])
  end

  def find(klass, id), do: Repo.get!(klass, id)

  def first(klass), do: klass |> Ecto.Query.first() |> Repo.one()

  def update(klass, item, attrs) do
    item
    |> klass.changeset(attrs)
    |> Repo.update()
  end
  
end
