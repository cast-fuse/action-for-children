defmodule ActionForChildren.Web.PageController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def index(conn, _params) do
    render conn, "index.html"
  end
end
