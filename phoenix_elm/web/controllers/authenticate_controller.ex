defmodule PhoenixElm.AuthenticateController do
  use PhoenixElm.Web, :controller

  @service PhoenixElm.Service.AuthenticateService

  def authenticate(conn, %{"email" => email, "password" => password}) do
    case @service.authenticate(email, password) do
      {:ok, %User{} = user} ->
        conn
        |> Helpers.update_authentication(user)
        |> elem(0)
        |> render("show.json", user: user)

      {:error, _} ->
        conn
        |> put_status(401)
        |> json("UNAUTHORIZED")
    end
  end

end