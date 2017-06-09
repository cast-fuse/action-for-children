defmodule ActionForChildren.Web.CallbackController do
  use ActionForChildren.Web, :controller
  alias ActionForChildren.{User, Web.Plugs.Auth}
  import ActionForChildren.Web.IntercomPrefferedTimes

  plug Auth

  def show(conn, _params) do
    case conn.assigns.user do
      %User{} ->
        render conn, "show.html"
      nil ->
        conn
        |> put_flash(:error, "you must be logged in")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def create(conn, %{"user_id" => user_id, "callback" => callback}) do
    message = format_message(callback)
    case send_preferred_times(%{user_id: user_id, message: message}) do
      {:ok, :message_sent, _} ->
        conn
        |> put_flash(:info, "thanks we'll get in touch")
        |> redirect(to: user_path(conn, :show, user_id))
      {:error, _} ->
        conn
        |> put_flash(:error, "something went wrong")
        |> render("show.html")
    end
  end
end
