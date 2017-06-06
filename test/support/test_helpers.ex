defmodule ActionForChildren.Web.TestHelpers do
  alias ActionForChildren.{Repo, User}
  def insert_user(attrs \\ %{}) do
    changes = Map.merge(%{
      uuid: Ecto.UUID.generate()
      }, attrs)

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!()
  end

  def to_shortcode(uuid) do
    uuid
    |> String.slice(0, 8)
    |> String.upcase()
  end
end
