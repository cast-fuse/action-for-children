defmodule ActionForChildren.Accounts do
  import Ecto.Query, warn: false
  alias ActionForChildren.{User, Repo}

  def get_user_by_shortcode(shortcode) do
    case Repo.one(user_shortcode(shortcode)) do
      %User{} = user ->
        cond do
          valid_shortcode?(user, shortcode) ->
            {:ok, user}

          true ->
            {:error, :user_not_found}
        end
      nil ->
        {:error, :user_not_found}
    end
  end


  def get_user_by_uuid(uuid), do: Repo.get_by(User, uuid: uuid)

  defp user_shortcode(shortcode) do
    shortcode_match = shortcode <> "%"
    from u in User, where: ilike(u.uuid, ^shortcode_match)
  end

  def valid_shortcode?(user, shortcode) do
    user_shortcode = user.uuid |> to_shortcode()
    user_shortcode == String.upcase(shortcode)
  end

  def to_shortcode(uuid) do
    uuid
    |> String.slice(0, 8)
    |> String.upcase()
  end

  def create_user(attrs \\ %{}) do
    uuid = attrs[:uuid] || Ecto.UUID.generate()
    %User{uuid: uuid}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
