defmodule PhoenixElm.HelpersController do
  use PhoenixElm.Web, :controller

  def update_authentication(conn, %User{} = user) do
    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {:ok, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    new_conn = new_conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> put_resp_header("x-expires", "#{exp}")

    {new_conn, jwt, claims}
  end

end