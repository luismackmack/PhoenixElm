defmodule PhoenixElm.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build and query models.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest

      alias PhoenixElm.{Repo, User}
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import PhoenixElm.Router.Helpers

      # The default endpoint for testing
      @endpoint PhoenixElm.Endpoint

      def register(user_params) do
        changeset = User.changeset(%User{}, user_params)
        {:ok, user}  = Repo.insert(changeset)
        user
      end

      def perform_as(user) do
        user
      end

      def test_user() do
        %{"firstname" => "test_firstname_user",
          "lastname" => "test_lastname_user",
          "email" => "test_user@example.com",
          "password" => "secret",
          "password_confirmation" => "secret",
          "phones" => "210-543-9876"
        }
      end

    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixElm.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PhoenixElm.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
