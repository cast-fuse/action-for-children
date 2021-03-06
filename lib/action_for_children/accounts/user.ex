defmodule ActionForChildren.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ActionForChildren.User

  schema "users" do
    field :uuid, :string
    field :email, :string
    field :token, :string
    field :token_expires, :naive_datetime
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:uuid, :email, :token, :token_expires])
    |> validate_required(:uuid)
    |> validate_required(:email, message: "please enter your email address")
  end

  defimpl Phoenix.Param, for: User do
    def to_param(%{uuid: uuid}), do: uuid
  end
end
