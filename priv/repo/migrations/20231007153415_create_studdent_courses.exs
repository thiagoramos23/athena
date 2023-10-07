defmodule Athena.Repo.Migrations.CreateStuddentCourses do
  use Ecto.Migration

  def change do
    create table(:student_courses) do
      add(:course_id, references(:courses, on_delete: :nothing))
      add(:student_id, references(:students, on_delete: :nothing))

      timestamps()
    end

    create index(:student_courses, [:course_id])
    create index(:student_courses, [:student_id])

    create unique_index(:student_courses, [:student_id, :course_id])
  end
end
