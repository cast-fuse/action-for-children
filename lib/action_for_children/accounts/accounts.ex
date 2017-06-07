defmodule ActionForChildren.Accounts do
  import Ecto.Query, warn: false
  alias ActionForChildren.{User, Repo}

  def get_user_by_uuid(uuid), do: Repo.get_by(User, uuid: uuid)

  def make_uuid do
    Ecto.UUID.generate()
    |> String.slice(0, 8)
    |> String.upcase()
  end

  def create_user(attrs \\ %{}) do
    uuid = attrs[:uuid] || make_uuid()
    %User{uuid: uuid}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
