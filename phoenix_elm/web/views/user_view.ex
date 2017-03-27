defmodule PhoenixElm.UserView do
  use PhoenixElm.Web, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email
    }
  end

end
