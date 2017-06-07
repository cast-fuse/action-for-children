defmodule ActionForChildren.Web.UserView do
  use ActionForChildren.Web, :view
  alias ActionForChildren.Accounts

  def render_shortcode(user), do: Accounts.to_shortcode(user.uuid)
end
