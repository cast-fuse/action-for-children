defmodule ActionForChildren.UserTest do
  use ActionForChildren.DataCase
  import ActionForChildren.Web.Router.Helpers

  alias ActionForChildren.User
  alias ActionForChildren.Web.Endpoint

  @valid_attrs %{uuid: Ecto.UUID.generate(), email: "test@example.com"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

end
