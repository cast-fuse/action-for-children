defmodule ActionForChildrenWeb.SessionController do
  use ActionForChildrenWeb, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildrenWeb.Plugs.Auth

  use Timex

  defp expired?(datetime) do
    Timex.after?(Timex.now(), Timex.shift(datetime, days: 1))
  end

  def create(conn, %{"session" => %{"uuid" => uuid, "email" => email}}) do
    case Accounts.get_user_by_uuid_and_email(uuid, email) do
      %User{} = user ->
        conn
        |> Auth.login(user)
        |> redirect(to: user_path(conn, :index))

      nil ->
        conn
        |> put_flash(
          :error,
          "Sorry, could not find that conversation, please start a new one using the option below"
        )
        |> redirect(to: page_path(conn, :index) <> "#speak-to-us")
    end
  end

  def create_from_token(conn, %{"token" => token}) do
    case Accounts.get_user_by_token(token) do
      %User{} = user ->
        case NaiveDateTime.compare(NaiveDateTime.utc_now(), user.token_expires) do
          :gt ->
            conn
            |> put_flash(
              :error,
              "Please sign in again."
            )
            |> redirect(to: page_path(conn, :index) <> "#speak-to-us")

          :lt ->
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

      nil ->
        conn
        |> put_flash(
          :error,
          "Sorry, could not find that conversation, please start a new one using the option below"
        )
        |> redirect(to: page_path(conn, :index) <> "#speak-to-us")
    end
  end

  def verify_from_email(conn, %{"token" => token}) do
    user = Accounts.get_user_by_token(token)

    case user do
      # 2. if token doesn't produce a user, redirect to home
      nil ->
        conn
        |> put_flash(:error, "Please enter your email here")
        |> redirect(to: page_path(conn, :index) <> "#speak-to-us")

      # 3. if token gets a user, check if token is expired
      user ->
        # 4. if expired, update user with token nil and expiry nil then redirect to home with error message
        if expired?(user.token_expires) do
          Accounts.update_token(user, %{token: nil, token_expires: nil})

          conn
          |> put_flash(:error, "Your verification link expired, please try again")
          |> redirect(to: page_path(conn, :index) <> "#speak-to-us")
        else
          # 5. if not expired, update user with nil values as well (so it can't be used again) and initiate session
          # and redirect to /users

          # Accounts.update_token(user, %{token: nil, token_expires: nil})

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

  def advice_login(conn, %{"code" => code, "email" => email}) do
    case code do
      "" ->
        case Accounts.get_user_by_email(email) do
          %User{} ->
            send_resp(
              conn,
              409,
              "This email is already registered, please enter your code or go to https://talk.actionforchildren.org.uk/new-code if you've forgotten it."
            )

          nil ->
            {:ok, %User{} = user} = Accounts.create_user_with_token(%{email: email})
            send_resp(conn, 201, user.token)
        end

      _ ->
        case Accounts.get_user_by_uuid_and_email(code, email) do
          %User{} = user ->
            new_token = Ecto.UUID.generate()
            token_expires = NaiveDateTime.add(NaiveDateTime.utc_now(), 60, :second)

            {:ok, %User{} = updatedUser} =
              Accounts.update_token(user, %{token: new_token, token_expires: token_expires})

            send_resp(conn, 201, updatedUser.token)

          nil ->
            send_resp(
              conn,
              409,
              "Sorry, we couldn't log you in with those details. Are you sure your code and email are correct? Go to https://talk.actionforchildren.org.uk/new-code if you need to change your code."
            )
        end
    end
  end

  def delete(conn, _params) do
    conn
    |> Auth.logout()
    |> put_flash(:info, "You have been logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
