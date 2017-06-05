defmodule ActionForChildren.Web.Plugs.Auth do
  import Plug.Conn
  alias ActionForChildren.Accounts

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    uuid = get_session(conn, :uuid)
    user = uuid && Accounts.get_user_by_uuid(uuid)
    assign(conn, :user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:user, user)
    |> put_session(:uuid, user.uuid)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
