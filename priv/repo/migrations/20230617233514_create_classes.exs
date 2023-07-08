defmodule Athena.Repo.Migrations.CreateClasses do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add(:name, :string, null: false)
      add(:description, :citext, null: false)
      add(:class_length, :integer, null: false)
      add(:class_text, :citext, null: false)
      add(:video_url, :string, null: false)
      add(:course_id, references(:courses), on_delete: :nothing, null: false)

      timestamps()
    end

    create index(:classes, [:course_id])
    create index(:classes, [:name])
    create index(:classes, [:description])
  end
end
