defmodule ZAuth.AuthenticationTest do
  use ExUnit.Case, async: true
  alias ZAuth.Authentication

  @password "forty-five failed fifers"

  test "encrypt is not idempotent" do
    refute Authentication.encrypt(@password) == Authentication.encrypt(@password)
  end

  test "password matches hash" do
    hash = Authentication.encrypt(@password)
    assert Authentication.password_matches?(@password, hash)
  end

  test "other password does not match hash" do
    hash = Authentication.encrypt(@password)
    refute Authentication.password_matches?("not a chance", hash)
  end
end
