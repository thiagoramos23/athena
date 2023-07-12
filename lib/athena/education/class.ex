defmodule Athena.Education.Class do
  @moduledoc """
  The class represents a unique class for a course.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field(:slug, :string)
    field(:name, :string)
    field(:description, :string)
    field(:class_length, :integer)
    field(:video_url, :string)
    field(:thumbnail_url, :string)
    field(:class_text, :string)
    belongs_to :course, Athena.Education.Course

    timestamps()
  end

  @required_fields [
    :slug,
    :name,
    :description,
    :class_length,
    :video_url,
    :thumbnail_url,
    :class_text,
    :course_id
  ]

  def changeset(class, attrs) do
    class
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)

    # Add validation to validate the uniqueness of the slug
  end
end
