defmodule ActionForChildren.Web.PageController do
  use ActionForChildren.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
