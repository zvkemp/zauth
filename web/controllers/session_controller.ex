defmodule ZAuth.SessionController do
  use ZAuth.Web, :controller
  alias ZAuth.UserAuthentication
  alias ZAuth.User

  def new(conn, _params) do
    conn |> render("new.html")
  end

  def create(conn, params) do
    # conn |> login(params)
    %{ "email" => email, "password" => password } = params
    user_id = Map.get(ZAuth.UserAuthentication.authenticate(email, password) || %{}, :id)
    conn |> put_session(:user_id, user_id)
         |> redirect(to: "/")
  end

  defp login(conn, %{ "email" => email, "password" => password}) do
    conn |> handle_login_response(user_id(email, password))
  end

  defp login(conn, _), do: handle_login_response(conn)

  defp user_id(email, password) do
    Map.get(UserAuthentication.authenticate(email, password) || %{}, :id)
  end

  defp handle_login_response(conn, user_id \\ nil)

  defp handle_login_response(conn, nil) do
    conn |> put_flash(:error, "Could not log you in")
         |> redirect(to: "/login")
  end

  defp handle_login_response(conn, user_id) when is_integer(user_id) do
    conn |> put_session(:user_id, user_id)
         |> put_flash(:info, "Welcome back!")
         |> redirect(to: "/")
  end
end
