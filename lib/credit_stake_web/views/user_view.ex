defmodule CreditStakeWeb.UserView do
  use CreditStakeWeb, :view
  alias CreditStakeWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      nickname: user.nickname,
      age: user.age
    }
  end
end
