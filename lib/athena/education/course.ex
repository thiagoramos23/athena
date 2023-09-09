defmodule Athena.Education.Course do
  @moduledoc """
  The course module that represents all the courses in the platform.
  Each course can have multiple classes and be featured or not.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field(:slug, :string)
    field(:name, :string)
    field(:description, :string)
    field(:featured, :boolean, default: false)
    has_many :classes, Athena.Education.Class

    many_to_many :teachers, Athena.Education.Teacher, join_through: Athena.Education.TeacherCourse

    timestamps()
  end

  @required_fields [:slug, :name, :description, :featured]

  def changeset(course, attrs) do
    course
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
