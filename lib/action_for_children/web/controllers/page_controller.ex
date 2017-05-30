defmodule ActionForChildren.Web.PageController do
  use ActionForChildren.Web, :controller
  require Intercom

  plug :intercom

  def index(conn, _params) do
    render conn, "index.html"
  end

  defp intercom(conn, _params) do
    {:ok, snippet} = Intercom.snippet(
      %{email: "ivan@wearecast.org.uk"},
      app_id: "jbn53yxb",
      secret: System.get_env("INTERCOM_SECRET")
    )
    assign(conn, :intercom, snippet)
  end
end
