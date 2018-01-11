defmodule ActionForChildren.UserTest do
  use ActionForChildren.DataCase
  import ActionForChildren.Web.Router.Helpers

  alias ActionForChildren.User
  alias ActionForChildren.Web.Endpoint

  @valid_attrs %{uuid: Ecto.UUID.generate()}
  @invalid_attrs %{}

end
