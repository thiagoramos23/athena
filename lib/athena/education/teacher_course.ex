defmodule Athena.Education.TeacherCourse do
  @moduledoc """
  This module represents the association between a teacher and courses.
  A teacher can lecture multiple courses and a course can have multiple teachers.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "teacher_courses" do
    belongs_to :teacher, Athena.Accounts.Teacher
    belongs_to :course, Athena.Education.Course
    timestamps()
  end

  @required_fields [:teacher_id, :class_id]

  def changeset(teacher_class, attrs) do
    teacher_class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
