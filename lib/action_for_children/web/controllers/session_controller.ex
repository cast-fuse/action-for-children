defmodule ActionForChildren.Web.SessionController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildren.Web.Plugs.Auth

  def create(conn, %{"session" => %{"uuid" => uuid, "email" => email}}) do
    case Accounts.get_user_by_uuid(uuid) do
      %User{} = user ->
        conn
        |> Auth.login(user)
        |> redirect(to: user_path(conn, :index))
      nil ->
        conn
        |> put_flash(:error, "Sorry, could not find that user")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "Logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
