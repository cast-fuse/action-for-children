defmodule ActionForChildren.Repo.Migrations.AddTokenExpires do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :token_expires, :naive_datetime
    end
  end
end
