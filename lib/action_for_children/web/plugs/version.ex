defmodule ActionForChildrenWeb.Plugs.Version do
  import Plug.Conn

  @advice "advice"
  @talk "talk"
  @versions [@advice, @talk]

  def init(opts) do
    opts
  end

  def call(%{assigns: %{version: _}} = conn, _opts), do: conn

  def call(conn, _opts) do
    session_version = get_session(conn, :version)
    param_version = get_params_version(conn.query_params)

    cond do
      !!param_version ->
        conn
        |> put_session(:version, param_version)
        |> assign(:version, param_version)
        |> configure_session(renew: true)

      !!session_version ->
        conn
        |> assign(:version, session_version)

      true ->
        conn
        |> assign(:version, @talk)
    end
  end

  defp get_params_version(query_params) do
    case query_params do
      %{"version" => version} ->
        if Enum.member?(@versions, version), do: version

      _ ->
        nil
    end
  end
end
