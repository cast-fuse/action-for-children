defmodule ActionForChildrenWeb.PageController do
  use ActionForChildrenWeb, :controller
  alias ActionForChildrenWeb.Plugs.Auth
  alias ActionForChildren.User

  plug Auth

  def index(%{assigns: %{user: %User{}}} = conn, _params) do
    conn
    |> redirect(to: user_path(conn, :index))
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def talk_to_us(conn, _params) do
    render conn, "talk_to_us.html"
  end

  def practitioners(conn, _params) do
    render conn, "practitioners.html"
  end

  def privacy(conn, _params) do
    render conn, "privacy.html"
  end
end
