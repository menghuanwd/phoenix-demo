defmodule CreditStake.Database2 do
  @moduledoc """
  The Database2 context.
  """

  import Ecto.Query, warn: false
  alias CreditStake.Repo

  def all(klass, query) do
    from(p in klass, order_by: [desc: p.created_at])
#    from(p in klass, order_by: [desc: p.published_at], preload: [:bank])
    |> Repo.paginate(page: query["page"], page_size: query["per"])
  end

  def find(klass, id), do: Repo.get!(klass, id)

#  CreditStake.Database2.first(CreditStake.Database.Article)
  def first(klass), do: klass |> Ecto.Query.first() |> Repo.one()

#  CreditStake.Database2.last(CreditStake.Database.Article)
  def last(klass), do: klass |> Ecto.Query.last() |> Repo.one()

  def update(klass, item, attrs) do
    item
    |> klass.changeset(attrs)
    |> Repo.update()
  end
  
end
