defmodule ActionForChildren.Web.AuthTest do
  use ActionForChildren.Web.ConnCase
  alias ActionForChildren.Web.Plugs.Auth

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(ActionForChildren.Web.Router, :browser)
      |> get("/")
    {:ok, %{conn: conn}}
  end

  test "init returns options as is" do
    assert Auth.init(%{}) == %{}
  end

  test "call with no user in session returns conn with user assigned to nil", %{conn: conn} do
    conn = Auth.call(conn, %{})
    assert conn.assigns.user == nil
  end

end
