defmodule ActionForChildren.Web.CallbackController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def show(conn, _params) do
    render conn, "show.html"
  end

end
