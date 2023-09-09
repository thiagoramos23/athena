defmodule Athena.Education.StudentClass do
  @moduledoc """
  This module represents the association between student and class.
  A student can take multiple classes and a class can have multiple students.
  This module exists so we can track the users progress through the courses.
  Here we can check how far they are going into the class and mark classes as
  completed.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "student_classes" do
    field(:time, :integer)
    field(:completed_at, :utc_datetime)
    belongs_to :student, Athena.Accounts.Student
    belongs_to :class, Athena.Education.Class
    timestamps()
  end

  @required_fields [:time, :completed_at, :student_id, :class_id]

  def changeset(student_class, attrs) do
    student_class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
