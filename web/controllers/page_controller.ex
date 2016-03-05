defmodule ZAuth.PageController do
  use ZAuth.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
