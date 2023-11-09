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
    field(:thumbnail_url, :string)
    field(:featured, :boolean, default: false)
    belongs_to(:teacher, Athena.Education.Teacher)

    has_many :classes, Athena.Education.Class
    many_to_many :students, Athena.Education.Student, join_through: Athena.Education.StudentCourse

    timestamps()
  end

  @required_fields [:slug, :name, :description, :thumbnail_url, :featured, :teacher_id]

  def changeset(course, attrs) do
    course
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
