defmodule ActionForChildren.Web.UserControllerTest do
  use ActionForChildren.Web.ConnCase

  test "creates a new user", %{conn: conn} do
    conn = post conn, "/users"
    %{assigns: %{user: user}} = conn

    assert String.length(user.uuid) == 36
    assert redirected_to(conn) == user_path(conn, :show, user)
  end
end
