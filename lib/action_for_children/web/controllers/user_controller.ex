defmodule ActionForChildren.Web.UserController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.Accounts
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def show(conn, %{"id" => code}) do
    case Accounts.get_user_by_code(code) do
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
    uuid = Ecto.UUID.generate()

    case Accounts.create_user(%{uuid: uuid}) do
      {:ok, user} ->
        conn
        |> Auth.login(user)
        |> redirect(to: user_path(conn, :show, user))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "error creating user")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
