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

  describe "articles" do
    alias CreditStake.Database.Article

    import CreditStake.DatabaseFixtures

    @invalid_attrs %{content: nil, summary: nil, title: nil, visits: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Database.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Database.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{content: "some content", summary: "some summary", title: "some title", visits: 42}

      assert {:ok, %Article{} = article} = Database.create_article(valid_attrs)
      assert article.content == "some content"
      assert article.summary == "some summary"
      assert article.title == "some title"
      assert article.visits == 42
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Database.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{content: "some updated content", summary: "some updated summary", title: "some updated title", visits: 43}

      assert {:ok, %Article{} = article} = Database.update_article(article, update_attrs)
      assert article.content == "some updated content"
      assert article.summary == "some updated summary"
      assert article.title == "some updated title"
      assert article.visits == 43
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Database.update_article(article, @invalid_attrs)
      assert article == Database.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Database.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Database.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Database.change_article(article)
    end
  end
end
