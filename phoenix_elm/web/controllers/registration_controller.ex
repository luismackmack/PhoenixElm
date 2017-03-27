defmodule PhoenixElm.RegistrationController do
  use PhoenixElm.Web, :controller
  
  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Helpers.update_authentication(user)
        |> elem(0)
        |> put_status(201)
        |> render("show.json", user: user)

      {:error, errors} ->
        conn
        |> put_status(404)
        |> render("error.json", errors: errors)
        
    end
  end
end