defmodule ActionForChildren.Web.TestHelpers do
  alias ActionForChildren.{Repo, User}
  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      uuid: Ecto.UUID.generate()
      }, attrs)

    %User{}
    |> User.changeset(changes)
    |> Repo.insert!()
  end
end
