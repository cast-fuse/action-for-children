defmodule ActionForChildren.Web.CallbackControllerTest do
  use ActionForChildren.Web.ConnCase

  test "logged in user is show callback view", %{conn: conn} do
    user = insert_user()
    conn = assign(conn, :user, user)
    conn = get conn, user_callback_path(conn, :show, user)

    contents = [
      "good to talk",
      "afternoon",
      "morning",
      "evening"
    ]

    Enum.map contents, fn content ->
      assert html_response(conn, 200) =~ content
    end
  end

  test "logged out user is redirected back to home page", %{conn: conn} do
    user = insert_user()
    conn = get conn, user_callback_path(conn, :show, user)

    assert get_flash(conn, :error) =~ "you must be logged in"
    assert get_session(conn, :uuid) == nil
    assert redirected_to(conn) == page_path(conn, :index)
  end

  @callback_info %{callback: %{topic: "Teething", phone: "071233345838", time: "morning", day: "monday"}}
  test "can send message to intercom", %{conn: conn} do
    user = insert_user(%{uuid: "EAC31107"})
    conn = post conn, user_callback_path(conn, :create, user), @callback_info
    assert get_flash(conn, :info) =~ "thanks we'll get in touch"
    assert redirected_to(conn) == user_path(conn, :show, user)
  end
end
