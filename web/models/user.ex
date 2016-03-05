defmodule ZAuth.User do
  use ZAuth.Web, :model

  schema "users" do
    field :email, :string
    field :encrypted_password, :string

    timestamps
  end

  @required_fields ~w(encrypted_password email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
    |> encrypt_new_password
  end

  alias ZAuth.Repo

  def create(params) do
    changeset(%ZAuth.User{}, params) |> Repo.insert
  end

  def find_by_email(email) do
    Repo.get_by(ZAuth.User, email: email)
  end

  defp encrypt_new_password(%{ params: %{ "password" => password }} = cs) do
    cs = Ecto.Changeset.put_change(
      cs, :encrypted_password, ZAuth.Authentication.encrypt(password)
    )
    changeset(cs.model, cs.changes)
  end

  defp encrypt_new_password(cs), do: cs
end
