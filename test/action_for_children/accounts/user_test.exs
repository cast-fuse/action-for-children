defmodule ActionForChildren.UserTest do
  use ActionForChildren.DataCase
  import ActionForChildren.Web.Router.Helpers

  alias ActionForChildren.User
  alias ActionForChildren.Web.Endpoint

  @uuid "3c1f7669-8ed2-4f3d-a41d-91a827496e91"
  @shortcode "3c1f7669"
  @valid_attrs %{uuid: @uuid}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "user_path uses uuid rather than id" do
    changeset = User.changeset(%User{}, @valid_attrs)
    user = Repo.insert!(changeset)
    assert user_path(Endpoint, :show, user) == "/users/" <> String.upcase @shortcode
  end
end
