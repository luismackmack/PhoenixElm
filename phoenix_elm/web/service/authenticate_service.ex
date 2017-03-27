defmodule PhoenixElm.Service.AuthenticateService do
  import Ecto.Query, only: [from: 2]

  alias PhoenixElm.{Repo, User}

  def authenticate(email, password) do
    Repo.one(from u in User, where: u.email == ^email)
    |> checkpw(password)
  end

  defp checkpw(nil, _password) do
    dummy_checkpw()
    {:error, :user_not_found}
  end

  defp checkpw(%User{} = user, password) do
    cond do
      checkpw?(password, user.password_hash) -> {:ok, user}
      :else -> {:error, :invalid_password}
    end
  end

  defp dummy_checkpw(),
    do: Comeonin.Bcrypt.dummy_checkpw()

  defp checkpw?(password, encrypted) do
    try do
      Comeonin.Bcrypt.checkpw(password, encrypted)
    rescue
      _ -> false
    end
  end

end