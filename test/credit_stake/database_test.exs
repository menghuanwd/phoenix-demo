defmodule CreditStake.DatabaseTest do
  use CreditStake.DataCase

  alias CreditStake.Database

  describe "banks" do
    alias CreditStake.Database.Bank

    import CreditStake.DatabaseFixtures

    @invalid_attrs %{name: nil}

    test "list_banks/0 returns all banks" do
      bank = bank_fixture()
      assert Database.list_banks() == [bank]
    end

    test "get_bank!/1 returns the bank with given id" do
      bank = bank_fixture()
      assert Database.get_bank!(bank.id) == bank
    end

    test "create_bank/1 with valid data creates a bank" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Bank{} = bank} = Database.create_bank(valid_attrs)
      assert bank.name == "some name"
    end

    test "create_bank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Database.create_bank(@invalid_attrs)
    end

    test "update_bank/2 with valid data updates the bank" do
      bank = bank_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Bank{} = bank} = Database.update_bank(bank, update_attrs)
      assert bank.name == "some updated name"
    end

    test "update_bank/2 with invalid data returns error changeset" do
      bank = bank_fixture()
      assert {:error, %Ecto.Changeset{}} = Database.update_bank(bank, @invalid_attrs)
      assert bank == Database.get_bank!(bank.id)
    end

    test "delete_bank/1 deletes the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{}} = Database.delete_bank(bank)
      assert_raise Ecto.NoResultsError, fn -> Database.get_bank!(bank.id) end
    end

    test "change_bank/1 returns a bank changeset" do
      bank = bank_fixture()
      assert %Ecto.Changeset{} = Database.change_bank(bank)
    end
  end
end
