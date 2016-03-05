
defmodule ZAuth.SessionControllerTest do
  alias ZAuth.User

  defmodule LoginTest do
    use ZAuth.ConnCase

    ExUnit.configure(exclude: :pending)

    setup do
      { :ok, user } = ZAuth.Repo.insert(
        User.changeset(%User{}, %{ email: "test@test.org", password: "password" })
      )

      { :ok, user: user, conn: conn() }
    end


    def create(conn, params \\ %{}) do
      post conn, session_path(conn, :create, params)
    end

    test "no email or password given", %{ conn: conn } do
      conn = conn |> create
      assert html_response(conn, 302)
      assert get_session(conn, :user_id) == nil
    end

    test "user logs in", %{ user: user, conn: conn } do
      conn = post conn, session_path(conn, :create, %{ email: user.email, password: "password" })
      assert html_response(conn, 302)
      assert get_session(conn, :user_id) == user.id
    end

    test "incorrect password given", %{ user: user, conn: conn } do
      conn = post conn, session_path(conn, :create, %{ email: user.email, password: "no match" })
      assert html_response(conn, 302)
      assert get_session(conn, :user_id) == nil
    end

    @tag :pending
    test "unknown email given", %{ conn: conn } do
      conn = post conn, session_path(conn, :create, %{ email: "missing@test.org", password: "password" })
      assert html_response(conn, 302)
      assert get_session(conn, :user_id) == nil
    end
  end
end
