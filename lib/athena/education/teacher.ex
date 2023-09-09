defmodule Athena.Education.Teacher do
  @moduledoc """
  The student module that represents all the students in the platform.
  A student is a user that is also a student.
  A user becomes a student when they signs up for a course.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "teachers" do
    field(:state, Ecto.Enum, values: [:active, :inactive], default: :active)
    belongs_to :user, Athena.Accounts.User
    many_to_many :courses, Athena.Education.Course, join_through: Athena.Education.TeacherCourse

    timestamps()
  end

  @required_fields [:state, :user_id]

  def changeset(course, attrs) do
    course
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
