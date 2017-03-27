defmodule PhoenixElm.RegistrationControllerTest do
  use PhoenixElm.ConnCase

  alias PhoenixElm.User
  @valid_attrs %{email: "somecontent@somecontent.com", firstname: "some content", lastname: "some content", password: "some content", password_confirmation: "some content"}
  @invalid_attrs %{}

  test "creates resource  when data is valid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @valid_attrs
    assert Repo.get_by(User, email: @valid_attrs.email)
  end

  test "does not create resource when data is invalid", %{conn: conn} do
    conn = post conn, registration_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 404)
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, registration_path(conn, :index)
    assert json_response(conn, 200)
  end
end
