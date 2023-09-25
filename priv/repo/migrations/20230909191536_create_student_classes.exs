defmodule Athena.Repo.Migrations.CreateStudentClasses do
  use Ecto.Migration

  def change do
    create table(:student_classes) do
      add(:time, :integer, null: false)
      add(:completed_at, :utc_datetime)
      add(:class_id, references(:classes, on_delete: :nothing))
      add(:student_id, references(:students, on_delete: :nothing))

      timestamps()
    end

    create index(:student_classes, [:class_id])
    create index(:student_classes, [:student_id])

    create unique_index(:student_classes, [:student_id, :class_id])
  end
end
