defmodule ActionForChildren.Web.CallbackController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{User, Web.Plugs.Auth, Accounts, Callback}
  import ActionForChildren.Web.IntercomPrefferedTimes

  plug Auth

  def show(%{assigns: %{user: %User{}}} = conn, _params) do
    render conn, "show.html", changeset: Accounts.new_callback()
  end

  def show(conn, _params) do
    conn
    |> put_flash(:error, "You must be logged in to see that page")
    |> redirect(to: page_path(conn, :index))
  end

  def create(conn, %{"callback" => callback} = params) do
    case Accounts.validate_callback(%Callback{}, callback) do
      {:ok, changeset} ->
        conn
        |> send_to_intercom(params, changeset)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Please fill in the missing fields")
        |> render("show.html", changeset: changeset)
    end
  end

  defp send_to_intercom(conn, %{"user_id" => user_id, "callback" => callback}, changeset) do
    message = format_message(callback)
    case send_preferred_times(%{user_id: user_id, message: message}) do
      {:ok, :message_sent, _} ->
        conn
        |> render("confirmation.html")
      {:error, reason} ->
        conn
        |> put_flash(:error, "error: #{reason}")
        |> render("show.html", changeset: changeset)
    end
  end
end
