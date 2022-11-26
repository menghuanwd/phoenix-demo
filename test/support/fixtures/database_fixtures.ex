defmodule CreditStake.DatabaseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CreditStake.Database` context.
  """

  @doc """
  Generate a unique bank name.
  """
  def unique_bank_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a bank.
  """
  def bank_fixture(attrs \\ %{}) do
    {:ok, bank} =
      attrs
      |> Enum.into(%{
        name: unique_bank_name()
      })
      |> CreditStake.Database.create_bank()

    bank
  end

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        content: "some content",
        summary: "some summary",
        title: "some title",
        visits: 42
      })
      |> CreditStake.Database.create_article()

    article
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        nickname: "some nickname"
      })
      |> CreditStake.Database.create_user()

    user
  end
end
