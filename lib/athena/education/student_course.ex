defmodule Athena.Education.StudentCourse do
  @moduledoc """
  This module represents the association between student and courses.
  A student can take multiple courses and a course can have multiple students
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "student_classes" do
    field(:time, :integer)
    field(:completed, :boolean, default: false)
    belongs_to :student, Athena.Accounts.Student
    belongs_to :class, Athena.Education.Class
    timestamps()
  end

  @required_fields [:time, :completed, :student_id, :class_id]

  def changeset(student_class, attrs) do
    student_class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
