defmodule ZAuth.Authentication do
  alias Plug.Crypto.KeyGenerator
  import Base, only: [encode64: 1]

  @iterations 65536

  def encrypt(string, salt \\ new_salt) do
    "#{salt}.#{hash(string, salt)}"
  end

  def password_matches?(password, hash) do
    [salt, _] = String.split(hash, ".")
    encrypt(password, salt) == hash
  end

  defp new_salt(length \\ 9) do
    :crypto.rand_bytes(length) |> encode64
  end

  defp hash(string, salt) do
    KeyGenerator.generate(string, salt <> secret, iterations: @iterations) |> encode64
  end

  defp secret, do: ZAuth.Endpoint.config(:secret_key_base)
end
