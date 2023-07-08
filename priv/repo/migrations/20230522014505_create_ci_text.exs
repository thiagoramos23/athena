defmodule Athena.Repo.Migrations.CreateCiText do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION citext;")
  end
end
