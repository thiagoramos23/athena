defmodule Athena.Education.Class do
  @moduledoc """
  The class represents a unique class for a course.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field(:slug, :string)
    field(:name, :string)
    field(:summary, :string)
    field(:description, :string)
    field(:class_length, :integer)
    field(:video_url, :string)
    field(:thumbnail_url, :string)
    field(:state, Ecto.Enum, values: [:public, :private], default: :public)
    belongs_to :course, Athena.Education.Course
    many_to_many :students, Athena.Education.Student, join_through: Athena.Education.StudentClass

    timestamps()
  end

  @required_fields [
    :slug,
    :name,
    :summary,
    :description,
    :class_length,
    :video_url,
    :thumbnail_url,
    :state,
    :course_id
  ]

  def changeset(class, attrs) do
    class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)

    # Add validation to validate the uniqueness of the slug
  end

  def public?(class) do
    class.state == :public
  end
end
