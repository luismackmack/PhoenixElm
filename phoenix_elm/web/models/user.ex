defmodule PhoenixElm.User do
  use PhoenixElm.Web, :model

  schema "users" do
    # personal data
    field :firstname, :string
    field :lastname, :string
    field :email, :string
    # authenticable
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  ##def changeset(model, type, params \\ %{})

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:firstname, :lastname, :email, :password_hash, :password, :password_confirmation])
    |> validate_required([:firstname, :lastname, :email, :password, :password_confirmation])
    |> validate_format(:email, ~r/@/)
    |> validate_tracking(params)
  end

  defp validate_tracking(changeset, params) do
    changeset
    |> validate_length(:password, min: 4)
    |> validate_password(params)
  end

  defp validate_password(changeset, params) do
    if is_nil(Map.get(changeset.data, :password_hash)) and is_nil(changeset.changes[:password]) do
      changeset
      |> add_error(:password, "can't be blank")
    else
      changeset
      |> validate_confirmation(:password)
      |> set_password(params)
    end
  end

  defp set_password(changeset, _params) do
    if changeset.valid? and not is_nil(changeset.changes[:password]) do
      put_change changeset, :password_hash,
        encrypt_password(changeset.changes[:password])
    else
      changeset
    end
  end

  defp encrypt_password(password),
    do: Comeonin.Bcrypt.hashpwsalt(password)




end
