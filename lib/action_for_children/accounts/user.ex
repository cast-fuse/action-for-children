defmodule ActionForChildren.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ActionForChildren.User

  schema "users" do
    field :uuid, :string
    field :email, :string
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:uuid, :email])
    |> validate_required(:uuid)
    |> validate_required(:email, message: "please enter your email address")
  end

  defimpl Phoenix.Param, for: User do
    def to_param(%{uuid: uuid, email: email}), do: uuid
  end
end
