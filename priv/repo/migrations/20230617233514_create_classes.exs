defmodule Athena.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add(:slug, :string, null: false)
      add(:name, :string, null: false)
      add(:summary, :citext, null: false)
      add(:description, :citext, null: false)
      add(:class_length, :integer, null: false)
      add(:video_url, :string, null: false)
      add(:thumbnail_url, :string, null: false)
      add(:state, :string, default: "public")
      add(:course_id, references(:courses, on_delete: :nothing), null: false)

      timestamps()
    end

    create index(:classes, [:course_id])
    create index(:classes, [:name])

    create unique_index(:classes, [:slug])
  end
end
