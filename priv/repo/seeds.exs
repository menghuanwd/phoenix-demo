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

alias CreditStake.Repo
alias CreditStake.Database.Bank

bank_infos = [%{
	name: "兴业银行",
	crawler_url: "https://creditcard.cib.com.cn/promotion/national/"
}]

for info <- bank_infos do
	Repo.insert(%Bank{name: info.name, crawler_url: info.crawler_url})
end

#for i <- CreditStake.Database.list_banks, do: CreditStake.Repo.delete(i)
#for i <- CreditStake.Database.list_articles, do: CreditStake.Repo.delete(i)