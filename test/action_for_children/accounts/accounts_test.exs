defmodule ActionForChildren.AccountsTest do
  use ActionForChildren.DataCase

  alias ActionForChildren.{Accounts, User, Callback}

  test "validate_callback/2 with valid data returns ok with a changeset and updated action" do
    params = %{
      phone: "07784823456",
      day: "mon",
      time: "afternooon"
    }
    {:ok, changeset} = Accounts.validate_callback(%Callback{}, params)

    assert changeset.valid?
    assert changeset.action == :send
    assert changeset.errors == []
  end

  test "validate_callback/2 with invalid data returns error with a changeset" do
    invalid_params = %{}
    {:error, changeset} = Accounts.validate_callback(%Callback{}, invalid_params)

    refute changeset.valid?
    assert length(changeset.errors) == 3
  end
end
