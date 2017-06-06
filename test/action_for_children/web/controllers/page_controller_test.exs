defmodule ActionForChildren.Web.PageControllerTest do
  use ActionForChildren.Web.ConnCase
  alias ActionForChildren.Accounts

  test "non logged in user sees options to start conversation and enter code", %{conn: conn} do
    conn = get conn, "/"

    contents = [
      "Action for Children",
      "intercom",
      "form",
      "conversation code",
    ]

    Enum.map contents, fn content ->
      assert html_response(conn, 200) =~ content
    end
  end

  test "logged in user only sees option to continue conversation", %{conn: conn} do
    {:ok, user} = Accounts.create_user(%{uuid: Ecto.UUID.generate()})
    conn = assign(conn, :user, user)
    conn = get conn, "/"

    contents = [
      "Action for Children",
      "intercom",
      "TALK TO AN EXPERT"
    ]

    excluded_content = [
      "conversation code",
      "enter your conversation code"
    ]

    Enum.map excluded_content, fn content ->
      refute html_response(conn, 200) =~ content
    end

    Enum.map contents, fn content ->
      assert html_response(conn, 200) =~ content
    end
  end
end
