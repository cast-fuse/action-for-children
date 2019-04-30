defmodule ActionForChildrenWeb.SessionController do
  use ActionForChildrenWeb, :controller
  alias ActionForChildren.{Accounts, User}
  alias ActionForChildrenWeb.Plugs.Auth

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
        |> redirect(to: page_path(conn, :talk_to_us))
    end
  end

  def create_from_token(conn, %{"token" => token}) do
    case Accounts.get_user_by_token(token) do
      %User{} = user ->
        time_diff_in_hours = NaiveDateTime.diff(NaiveDateTime.utc_now(), user.updated_at) / 3600

        case time_diff_in_hours > 24 do
          true ->
            conn
            |> put_flash(
              :error,
              "Sorry, your token has expired. Please sign in again."
            )
            |> redirect(to: page_path(conn, :talk_to_us))

          false ->
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
        |> redirect(to: page_path(conn, :talk_to_us))
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
            send_resp(conn, 201, user.token)

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
