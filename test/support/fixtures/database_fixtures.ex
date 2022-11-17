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
end
