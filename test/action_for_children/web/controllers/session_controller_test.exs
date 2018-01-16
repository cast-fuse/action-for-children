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

end
