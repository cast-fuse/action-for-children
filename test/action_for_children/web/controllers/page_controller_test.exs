defmodule ActionForChildren.Web.PageControllerTest do
  use ActionForChildren.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Action for Children"
  end
end
