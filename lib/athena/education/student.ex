defmodule Athena.Education.Student do
  @moduledoc """
  The student module that represents all the students in the platform.
  A student is a user that is also a student.
  A user becomes a student when they signs up for a course.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field(:state, Ecto.Enum, values: [:paid, :scholarship, :free], default: :free)
    belongs_to :user, Athena.Accounts.User
    many_to_many :courses, Athena.Education.Class, join_through: Athena.Education.StudentCourse
    many_to_many :classes, Athena.Education.Class, join_through: Athena.Education.StudentClass

    timestamps()
  end

  @required_fields [:state, :user_id]

  def changeset(student, attrs) do
    student
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
