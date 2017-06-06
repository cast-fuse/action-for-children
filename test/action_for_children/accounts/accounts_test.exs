defmodule ActionForChildren.Accounts.AccountsTest do
  use ActionForChildren.DataCase

  alias ActionForChildren.{Accounts, User}


  @uuid "3c1f7669-8ed2-4f3d-a41d-91a827496e91"
  @shortcode "3c1f7669"
  @invalid_shortcode "3s4f5882"

  test "get_user_by_shortcode/1 gets correct user" do
    Repo.insert!(%User{uuid: @uuid})

    assert {:ok, user} = Accounts.get_user_by_shortcode(@shortcode)
    assert user.uuid == @uuid
  end

  test "get_user_by_shortcode/1 errors for non-existing user" do
    assert {:error, :user_not_found} = Accounts.get_user_by_shortcode(@invalid_shortcode)
  end

  test "get_user_by_uuid/1 fetches correct user" do
    Repo.insert!(%User{uuid: @uuid})
    assert (%User{} = user) = Accounts.get_user_by_uuid(@uuid)
    assert user.uuid == @uuid
  end

  test "get_user_by_uuid/1 returns nil for non-existing user" do
    assert Accounts.get_user_by_uuid(@uuid) == nil
  end
end
