defmodule CreditStake.Database do
  @moduledoc """
  The Database context.
  """

  import Ecto.Query, warn: false
  alias CreditStake.Repo

  alias CreditStake.Database.Bank

  @doc """
  Returns the list of banks.

  ## Examples

      iex> list_banks()
      [%Bank{}, ...]

  """
  def list_banks do
    Repo.all(Bank)
  end

  @doc """
  Gets a single bank.

  Raises `Ecto.NoResultsError` if the Bank does not exist.

  ## Examples

      iex> get_bank!(123)
      %Bank{}

      iex> get_bank!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bank!(id), do: Repo.get!(Bank, id)

  def get_first_bank() do
    Bank |> first |> Repo.one()
  end

  @doc """
  Creates a bank.

  ## Examples

      iex> create_bank(%{field: value})
      {:ok, %Bank{}}

      iex> create_bank(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bank(attrs \\ %{}) do
    %Bank{}
    |> Bank.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bank.

  ## Examples

      iex> update_bank(bank, %{field: new_value})
      {:ok, %Bank{}}

      iex> update_bank(bank, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bank(%Bank{} = bank, attrs) do
    bank
    |> Bank.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bank.

  ## Examples

      iex> delete_bank(bank)
      {:ok, %Bank{}}

      iex> delete_bank(bank)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bank(%Bank{} = bank) do
    Repo.delete(bank)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bank changes.

  ## Examples

      iex> change_bank(bank)
      %Ecto.Changeset{data: %Bank{}}

  """
  def change_bank(%Bank{} = bank, attrs \\ %{}) do
    Bank.changeset(bank, attrs)
  end

  alias CreditStake.Database.Article

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles(query \\ nil) do
    page =
      from(p in Article, order_by: [asc: p.inserted_at, asc: p.id])
      |> Repo.paginate(page: query.page)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
