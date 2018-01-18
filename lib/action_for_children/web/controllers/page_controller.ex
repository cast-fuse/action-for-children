defmodule ActionForChildren.Web.PageController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.Web.Plugs.Auth
  alias ActionForChildren.User

  plug Auth

  def index(%{assigns: %{user: %User{} = user}} = conn, _params) do
    conn
    |> redirect(to: user_path(conn, :index))
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def experts(conn, _params) do
    render conn, "experts.html"
  end
end
