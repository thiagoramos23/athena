defmodule Athena.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add(:name, :string, null: false)
      add(:description, :string, null: false)
      add(:featured, :boolean, null: false, default: false)
      timestamps()
    end

    create(index(:courses, [:name]))
    create(index(:courses, [:featured]))
  end
end
