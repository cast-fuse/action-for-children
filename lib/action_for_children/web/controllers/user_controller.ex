defmodule ActionForChildren.Web.UserController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildren.Web.Plugs.Auth

  plug Auth

  def new_code(conn, _params) do
    
    render conn, "new_code.html"
  end

  def index(conn, _params) do

    uuid = get_session(conn, :uuid)

    if uuid == nil do

      conn
      |> put_flash(:error, "Please select an option below first")
      |> redirect(to: "#{page_path(conn, :index)}#talk")

    else

      case Accounts.get_user_by_uuid(uuid) do
        %User{} = user ->
          conn
          |> render("show.html", user: user)
        nil ->
          conn
          |> put_flash(:error, "Please select an option below first")
          |> redirect(to: "#{page_path(conn, :index)}#talk")
      end

    end

  end

  def create(conn, %{"user" => %{"email" => email}}) do

    if email == "" do

      conn
      |> put_flash(:error, "Please enter a valid email address")
      |> redirect(to: "#{page_path(conn, :index)}#talk")

    else

      case Accounts.get_user_by_email(email) do
        %User{} = user ->
          conn
          |> put_flash(:error, "Email address already in use, please continue your conversation using your unique code below")
          |> redirect(to: "#{page_path(conn, :index)}#talk")
        nil ->
          {:ok, user} = Accounts.create_user(%{email: email})
          conn
          |> Auth.login(user)
          |> redirect(to: user_path(conn, :index))
        end

      end

  end
end
