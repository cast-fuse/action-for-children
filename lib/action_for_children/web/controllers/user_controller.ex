defmodule ActionForChildren.Web.UserController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.Accounts
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def show(conn, %{"id" => code}) do
    case Accounts.get_user_by_shortcode(code) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> render("show.html", user: user)
      {:error, :user_not_found} ->
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
