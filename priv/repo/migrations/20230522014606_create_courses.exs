defmodule Athena.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add(:slug, :string, null: false)
      add(:name, :string, null: false)
      add(:description, :string, null: false)
      add(:thumbnail_url, :string, null: false)
      add(:featured, :boolean, null: false, default: false)
      add(:teacher_id, references(:teachers, on_delete: :nothing), null: false)
      timestamps()
    end

    create(index(:courses, [:name]))
    create(index(:courses, [:featured]))
    create(index(:courses, [:teacher_id]))

    create unique_index(:courses, [:slug])
  end
end
