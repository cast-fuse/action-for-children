defmodule ActionForChildren.Web.SessionController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildren.Web.Plugs.Auth

  def create(conn, %{"session" => %{"uuid" => uuid, "email" => email}}) do
    case Accounts.get_user_by_uuid_and_email(uuid, email) do
      %User{} = user ->
        conn
        |> Auth.login(user)
        |> redirect(to: user_path(conn, :index))
      nil ->
        conn
        |> put_flash(:error, "Sorry, could not find that conversation, please start a new one using the option below")
        |> redirect(to: "#{page_path(conn, :index)}#talk")
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: "#{page_path(conn, :index)}#talk")
  end
end
