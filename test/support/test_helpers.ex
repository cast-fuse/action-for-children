defmodule ActionForChildren.Web.TestHelpers do
  alias ActionForChildren.{Repo, User}
  def insert_user(attrs \\ %{}) do
    uuid =
      Ecto.UUID.generate()
      |> String.slice(0, 8)
      |> String.upcase()

    %User{uuid: uuid}
    |> User.changeset(attrs)
    |> Repo.insert!()
  end
end
