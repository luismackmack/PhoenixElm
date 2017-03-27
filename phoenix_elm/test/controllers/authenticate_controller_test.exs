defmodule PhoenixElm.AuthenticateControllerTest do
  use PhoenixElm.ConnCase

  setup do
    user = test_user() |> register() |> perform_as()
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user}
  end

  test "authenticate/2 with known email, valid password succeeds", (%{conn: conn, user: user}) do
    conn = post conn, authenticate_path(conn, :authenticate), %{ email: user.email, password: user.password }
    assert json_response(conn, 200)
    assert Regex.match?(~r/Bearer/, conn |> get_resp_header("authorization") |> hd)
  end

  test "authenticate/2  with known email fails", (%{conn: conn, user: user}) do
    conn = post conn, authenticate_path(conn, :authenticate), %{ email: "invalid_email", password: user.password }
    assert json_response(conn, 401)
  end

  test "authenticate/2 with known email, with known password fails", (%{conn: conn, user: user}) do
    conn = post conn, authenticate_path(conn, :authenticate), %{ email: user.email, password: "invalid__password" }
    assert json_response(conn, 401)
  end

  test "authenticate/2 with known email and password fails", (%{conn: conn, user: user}) do
    conn = post conn, authenticate_path(conn, :authenticate), %{ email: "invalid_email", password: "invalid__password" }
    assert json_response(conn, 401)
  end

end