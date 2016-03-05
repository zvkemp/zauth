defmodule ZAuth.UserAuthentication do
  alias ZAuth.Authentication
  alias ZAuth.User

  def authenticate(email, password) do
    (user = User.find_by_email(email))
    && Authentication.password_matches?(password, user.encrypted_password)
    && user
    || nil
  end
end
