defmodule ActionForChildren.Web.UserController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def index(conn, _params) do

    uuid = get_session(conn, :uuid)

    if uuid == nil do

      conn
      |> put_flash(:error, "Please login first")
      |> redirect(to: page_path(conn, :index))

    else

      case Accounts.get_user_by_uuid(uuid) do
        %User{} = user ->
          conn
          |> render("show.html", user: user)
        nil ->
          conn
          |> put_flash(:error, "Please login first")
          |> redirect(to: page_path(conn, :index))
      end

    end

  end

  def create(conn, _params) do
    {:ok, user} = Accounts.create_user()

    conn
    |> Auth.login(user)
    |> redirect(to: user_path(conn, :index))
  end
end
