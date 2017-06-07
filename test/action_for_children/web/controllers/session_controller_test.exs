defmodule ActionForChildren.Web.SessionControllerTest do
  use ActionForChildren.Web.ConnCase

  setup %{conn: conn} = config do
    if config[:login] do
      user = insert_user()
      conn = assign(build_conn(), :user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  test "creates a new session", %{conn: conn} do
    user = insert_user()
    conn = post conn, "/sessions", %{session: %{uuid: user.uuid}}

    assert get_session(conn, :uuid) == user.uuid
    assert redirected_to(conn) == user_path(conn, :show, user)
  end

  test "no session created if unknown user", %{conn: conn} do
    shortcode = "123"
    conn = post conn, "/sessions", %{session: %{uuid: shortcode}}

    assert get_flash(conn, :error) =~ "sorry could not find that user"
    assert get_session(conn, :uuid) == nil
    assert redirected_to(conn) == page_path(conn, :index)
  end

  @tag :login
  test "session expires on logout", %{conn: conn, user: user} do
    conn = delete conn, session_path(conn, :delete, user)

    assert get_flash(conn, :info) =~ "logged out"
    assert get_session(conn, :uuid) == nil
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
