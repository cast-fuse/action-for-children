defmodule ActionForChildren.Web.SessionController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildren.Web.Plugs.Auth

  def create(conn, %{"session" => %{"id" => shortcode}}) do
    case Accounts.get_user_by_code(shortcode) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> redirect(to: user_path(conn, :show, user))
      {:error, :user_not_found} ->
        conn
        |> put_flash(:error, "sorry could not find that user")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
