defmodule ActionForChildren.AccountsTest do
  use ActionForChildren.DataCase

  alias ActionForChildren.{Accounts, User}

  test "get_user_by_shortcode/1 gets correct user" do
    existing_user = insert_user()
    shortcode = to_shortcode(existing_user.uuid)

    assert {:ok, user} = Accounts.get_user_by_shortcode(shortcode)
    assert existing_user.uuid == user.uuid
  end

  test "get_user_by_shortcode/1 errors for non-existing user" do
    shortcode =
      Ecto.UUID.generate()
      |> to_shortcode
    assert {:error, :user_not_found} = Accounts.get_user_by_shortcode(shortcode)
  end

  test "get_user_by_uuid/1 fetches correct user" do
    existing_user = insert_user()
    assert (%User{} = user) = Accounts.get_user_by_uuid(existing_user.uuid)
    assert existing_user.uuid == user.uuid
  end

  test "get_user_by_uuid/1 returns nil for non-existing user" do
    uuid = Ecto.UUID.generate()
    assert Accounts.get_user_by_uuid(uuid) == nil
  end
end
