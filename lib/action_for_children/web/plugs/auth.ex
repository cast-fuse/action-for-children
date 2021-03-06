defmodule ActionForChildrenWeb.Plugs.Auth do
  import Plug.Conn
  alias ActionForChildren.Accounts
  alias ActionForChildren.User

  def init(opts) do
    opts
  end

  def call(%{assigns: %{user: %User{}}} = conn, _opts), do: conn

  def call(conn, _opts) do
    uuid = get_session(conn, :uuid)

    if user = uuid && Accounts.get_user_by_uuid(uuid) do
      assign(conn, :user, user)
    else
      assign(conn, :user, nil)
    end
  end

  def login(conn, user) do
    conn
    |> assign(:user, user)
    |> put_session(:uuid, user.uuid)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    delete_session(conn, :uuid)
  end
end
