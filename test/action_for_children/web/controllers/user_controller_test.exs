defmodule ActionForChildren.Web.UserControllerTest do
  use ActionForChildren.Web.ConnCase

  test "creates a new user", %{conn: conn} do
    conn = post conn, "/users"
    %{assigns: %{user: user}} = conn

    assert String.length(user.uuid) == 36
    assert redirected_to(conn) == user_path(conn, :show, user)
  end

  test "redirects to home if no user found", %{conn: conn} do
    conn = get conn, "/users/123"

    assert get_flash(conn, :error) =~ "sorry could not find that user"
    assert redirected_to(conn) == page_path(conn, :index)
  end

  test "shows user with the correct shortcode and auto logs them in", %{conn: conn} do
    user = insert_user()
    conn = get conn, user_path(conn, :show, user)
    %{assigns: %{user: user}} = conn

    assert String.length(user.uuid) == 36
    assert html_response(conn, 200) =~ user.uuid
  end
end
