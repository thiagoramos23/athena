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
    field(:name, :string)
    field(:email, :string)
    belongs_to :user, Athena.Accounts.User

    has_many(:courses, Athena.Education.Course)

    timestamps()
  end

  @required_fields [:state, :user_id, :name, :email]

  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, @required_fields)
    |> unique_constraint([:email])
    |> validate_required(@required_fields)
  end
end
