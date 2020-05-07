defmodule ActionForChildrenWeb.UserController do
  use ActionForChildrenWeb, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildrenWeb.Plugs.Auth
  alias SendGrid.{Email, Mailer}

  plug Auth

  def index(conn, params) do
    # uuid = get_session(conn, :uuid)

    %{"token" => token, "token_expires" => token_expires} = params
    {:ok, %NaiveDateTime{} = token_expires} = NaiveDateTime.from_iso8601(token_expires)

    case NaiveDateTime.compare(token_expires, NaiveDateTime.utc_now()) do
      :gt ->
        case Accounts.get_user_by_token(token) do
          nil ->
            conn
            |> put_flash(:error, "Please enter your email here")
            |> redirect(to: page_path(conn, :index) <> "#speak-to-us")

          %User{} = user ->
            conn
            |> render("show.html", user: user)
        end

      :lt ->
        conn
        |> put_flash(:error, "Your verification link expired, please try again")
        |> redirect(to: page_path(conn, :index) <> "#speak-to-us")
    end
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    case Accounts.get_user_by_email(email) do
      %User{} = user ->
        new_token = Ecto.UUID.generate()
        token_expires = NaiveDateTime.add(NaiveDateTime.utc_now(), 24, :hour)

        {:ok, %User{} = updatedUser} =
          Accounts.update_token(user, %{token: new_token, token_expires: token_expires})

        Email.build()
        |> Email.add_to(user.email)
        |> Email.put_from("parents@actionforchildren.org.uk")
        |> Email.put_subject("Action for Children email verification")
        |> Email.put_html(
          "<p>
            <a href='http://localhost:4000/users?token=#{updatedUser.token}&token_expires=#{
            updatedUser.token_expires
          }'>Click here</a> to verify your email.
          </p>
          <p>
          You’ll be taken back to our live chat, where you can start a new conversation with a parenting coach, or see the previous conversations you’ve had.
          </p>"
        )
        |> Mailer.send()

        conn
        |> redirect(to: page_path(conn, :verify))

      nil ->
        {:ok, %User{} = user} = Accounts.create_user_with_token(%{email: email})

        headers = [
          Authorization: "Bearer #{System.get_env("INTERCOM_SECRET")}",
          Accept: "application/json",
          "Content-Type": "application/json"
        ]

        body = Poison.encode!(%{user_id: user.uuid, email: user.email})

        HTTPoison.post(
          "https://api.intercom.io/users",
          body,
          headers
        )

        conn
        |> Auth.login(user)
        |> redirect(to: user_path(conn, :index))
    end
  end
end
