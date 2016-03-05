defmodule ZAuth.Router do
  use ZAuth.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :log_user_id
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ZAuth do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", ZAuth do
  #   pipe_through :api
  # end

  require Logger

  defp log_user_id(conn, _) do
    Logger.info("user_id: #{get_session(conn, :user_id) |> inspect}")
    conn
  end
end
