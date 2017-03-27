defmodule PhoenixElm.RegistrationView do
  use PhoenixElm.Web, :view

  alias PhoenixElm.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json", as: :user)}
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json", as: :user)}
  end

  def render("error.json", %{errors: errors}) do
    %{errors: %{detail: "errors"}}
  end
end