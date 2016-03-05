defmodule ZAuth.UserAuthenticationTest do
  use ZAuth.ModelCase
  alias ZAuth.UserAuthentication
  alias ZAuth.User

  @password "forty-five failed fifers"
  @email "test@test.org"

  setup do
    { :ok, user } = User.create(%{ email: @email, password: @password })
    { :ok, user: user }
  end

  test "with correct password", %{ user: user } do
    assert UserAuthentication.authenticate(@email, @password) == user
  end

  test "with incorrect password" do
    assert User.find_by_email(@email)
    refute UserAuthentication.authenticate(@email, "hey there")
  end

  test "with incorrect email" do
    refute User.find_by_email("email@test.org")
    refute UserAuthentication.authenticate("email@test.org", @password)
  end
end
