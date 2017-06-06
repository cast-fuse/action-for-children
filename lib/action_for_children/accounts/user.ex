defmodule ActionForChildren.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ActionForChildren.{User, Accounts}

  schema "users" do
    field :uuid, :string
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:uuid])
    |> validate_required([:uuid])
  end

  defimpl Phoenix.Param, for: User do
    def to_param(%{uuid: uuid}), do: Accounts.make_shortcode(uuid)
  end
end