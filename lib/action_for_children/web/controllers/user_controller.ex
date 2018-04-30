defmodule ActionForChildrenWeb.UserController do
  use ActionForChildrenWeb, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildrenWeb.Plugs.Auth

  plug Auth

  def new_code(conn, _params) do

    conn
    |> render("new_code.html")

  end

  def generate_new_code(conn, %{"user" => %{"email" => email}}) do

    case Accounts.get_user_by_email(email) do
      %User{} = user ->
        SendGrid.Email.build()
        |> SendGrid.Email.add_to(user.email)
        |> SendGrid.Email.put_from("ask.us@actionforchildren.org.uk")
        |> SendGrid.Email.put_subject("Your Action For Children Code")
        |> SendGrid.Email.put_text("Your code is #{user.uuid}")
        |> SendGrid.Mailer.send()

        conn
        |> put_flash(:error, "We have sent you an email with your new code, please check your inbox")
        |> redirect(to: "#{user_path(conn, :new_code)}")
      nil ->
        conn
        |> put_flash(:error, "Can not find your email address, start a new conversation instead?")
        |> redirect(to: "#{page_path(conn, :index)}#talk")
    end

  end

  def index(conn, _params) do

    uuid = get_session(conn, :uuid)

    if uuid == nil do

      conn
      |> put_flash(:error, "Please select an option below first")
      |> redirect(to: page_path(conn, :talk_to_us))

    else

      case Accounts.get_user_by_uuid(uuid) do
        %User{} = user ->
          conn
          |> render("show.html", user: user)
        nil ->
          conn
          |> put_flash(:error, "Please select an option below first")
          |> redirect(to: page_path(conn, :talk_to_us))
      end

    end

  end

  def create(conn, %{"user" => %{"email" => email}}) do

    if email == "" do

      conn
      |> put_flash(:error, "Please enter a valid email address")
      |> redirect(to: page_path(conn, :talk_to_us))

    else

      case Accounts.get_user_by_email(email) do
        %User{} = _user ->
          conn
          |> put_flash(:error, "Email address already in use, please continue your conversation using your unique code below")
          |> redirect(to: page_path(conn, :talk_to_us))
        nil ->
          {:ok, user} = Accounts.create_user(%{email: email})
          conn
          |> Auth.login(user)
          |> redirect(to: user_path(conn, :index))
        end

      end

  end
end
