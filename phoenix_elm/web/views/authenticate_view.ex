defmodule PhoenixElm.AuthenticateView do
  use PhoenixElm.Web, :view

  alias PhoenixElm.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json", as: :user)}
  end

end