defmodule Athena.Education.StudentCourse do
  @moduledoc """
  This module represents the association between student and courses.
  A student can take multiple courses and a course can have multiple students
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "student_courses" do
    belongs_to :student, Athena.Education.Student
    belongs_to :course, Athena.Education.Course
    timestamps()
  end

  @required_fields [:student_id, :course_id]

  def changeset(student_course, attrs) do
    student_course
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
