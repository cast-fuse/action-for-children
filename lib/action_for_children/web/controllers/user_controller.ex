defmodule ActionForChildren.Web.UserController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def show(conn, %{"id" => uuid}) do
    case Accounts.get_user_by_uuid(uuid) do
      %User{} = user ->
        conn
        |> Auth.login(user)
        |> render("show.html", user: user)
      nil ->
        conn
        |> put_flash(:error, "sorry could not find that user")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def create(conn, _params) do
    {:ok, user} = Accounts.create_user()

    conn
    |> Auth.login(user)
    |> redirect(to: user_path(conn, :show, user))
  end
end
