defmodule ActionForChildren.Web.PageControllerTest do
  use ActionForChildren.Web.ConnCase
  alias ActionForChildren.Accounts

  test "non logged in user sees options to start conversation and enter code", %{conn: conn} do
    conn = get conn, "/"

    contents = [
      "Action for Children",
      "intercom",
      "Talk to an expert",
      "form",
      "user code",
    ]

    Enum.map contents, fn content ->
      assert html_response(conn, 200) =~ content
    end
  end

  test "logged in user only sees option to continue conversation", %{conn: conn} do
    {:ok, user} = Accounts.create_user()
    conn = assign(conn, :user, user)
    conn = get conn, "/"

    contents = [
      "Action for Children",
      "intercom",
      "Talk to an expert"
    ]

    excluded_content = [
      "user code",
      "put your code here"
    ]

    Enum.map excluded_content, fn content ->
      refute html_response(conn, 200) =~ content
    end

    Enum.map contents, fn content ->
      assert html_response(conn, 200) =~ content
    end
  end
end
