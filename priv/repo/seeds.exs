# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CreditStake.Repo.insert!(%CreditStake.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

bank = CreditStake.Repo.insert!(%CreditStake.Database.Bank{name: "建设银行"})
CreditStake.Repo.insert!(%CreditStake.Database.Article{title: "中奖了", bank: bank})
CreditStake.Repo.insert!(%CreditStake.Database.Article{title: "没中奖", bank: bank})

for i <- CreditStake.Database.list_banks, do: Repo.delete(i)
for i <- CreditStake.Database.list_articles, do: Repo.delete(i)