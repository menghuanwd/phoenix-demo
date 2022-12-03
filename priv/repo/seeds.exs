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
alias CreditStake.Database
alias CreditStake.Database.Bank

bank_infos = [
  %{
    name: "兴业银行",
    crawler_url: "https://creditcard.cib.com.cn/promotion/national/"
  },
  %{
    name: "邮储银行",
    crawler_url: "https://www.psbc.com/cn/grfw/xyk/tyhd/qgthhd/index.html"
  },
	%{
		name: "民生银行",
		crawler_url: "https://creditcard.cmbc.com.cn/fe/jsp/activity/activityListPc.jsp"
	}
]

#for info <- bank_infos do
#  Repo.insert(%Bank{name: info.name, crawler_url: info.crawler_url})
#end

for info <- bank_infos do
	with {:ok, %Bank{} = bank} <- Database.create_bank(%{name: info.name, crawler_url: info.crawler_url}) do
	end
end


Database.create_user(%{nickname: "dave", age: "29"})

# for i <- CreditStake.Database.list_banks, do: CreditStake.Repo.delete(i)
# for i <- CreditStake.Database.list_articles, do: CreditStake.Repo.delete(i)
# for i <- CreditStake.Database2.all(CreditStake.Database.Article, %{}), do: CreditStake.Repo.delete(i)
