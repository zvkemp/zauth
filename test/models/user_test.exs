defmodule ZAuth.UserTest do
  use ZAuth.ModelCase

  alias ZAuth.User

  @valid_attrs %{email: "some content", password: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset with no password change" do
    changeset = User.changeset(%User{ encrypted_password: "abcdef" }, %{ email: "test" })
    assert changeset.valid?
    refute Map.has_key?(changeset,:encrypted_password)
  end
end
