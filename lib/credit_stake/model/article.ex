defmodule CreditStake.Model.Article do
	@moduledoc """
	The Database context.
	"""
	
	import Ecto.Query, warn: false
	
	alias CreditStake.Repo
	alias CreditStake.Database.Article, as: Schema
	
	def all(query \\ %{}) do
		from(p in Schema, order_by: [desc: p.created_at], preload: [:bank])
		|> Repo.paginate(page: query["page"], page_size: query["per"])
	end
	
	def find(id) do
		Repo.get!(Schema, id)
		|> Repo.preload([:bank])
	end
	
	def first, do: Schema |> Ecto.Query.first() |> Repo.one()
	
	def last, do: Schema |> Ecto.Query.last() |> Repo.one()
	
	def create(attrs \\ %{}) do
		%Schema{}
		|> Schema.changeset(attrs)
		|> Repo.insert()
	end
	
	def update(attrs) do
		find(attrs["id"])
		|> Schema.changeset(attrs)
		|> Repo.update()
	end
	
	def destroy(id) do
		Repo.delete(find(id))
	end
end
