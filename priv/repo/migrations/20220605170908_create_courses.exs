defmodule Athena.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :slug_name, :string
      add :slug, :uuid
      add :description, :string
      add :full_description, :string
      add :price, :integer
      add :cover_image_url, :string
      add :labels, :string

      timestamps()
    end
  end
end
