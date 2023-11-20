defmodule Athena.Education.Class do
  @moduledoc """
  The class represents a unique class for a course.
  """
  use Ecto.Schema
  import Ecto.Changeset

  # The states means:
  # - public = Anyone can see the class
  # - private = Only logged in users can see the class
  # - paid = Only paid users (customers) can see those classes
  # - soon = A class that is not ready to anyone to see yet but is is already registered in the platform
  @states [:public, :private, :paid, :soon]

  schema "classes" do
    field(:slug, :string)
    field(:name, :string)
    field(:summary, :string)
    field(:description, :string)
    field(:class_length, :integer)
    field(:video_url, :string)
    field(:thumbnail_url, :string)
    field(:state, Ecto.Enum, values: @states, default: :public)
    belongs_to :course, Athena.Education.Course
    many_to_many :students, Athena.Education.Student, join_through: Athena.Education.StudentClass

    field :completed, :boolean, virtual: true, default: false

    timestamps()
  end

  @required_fields [
    :slug,
    :name,
    :summary,
    :description,
    :class_length,
    :thumbnail_url,
    :state,
    :course_id
  ]

  @fields @required_fields ++ [:video_url]

  def changeset(class, attrs) do
    class
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:slug])
  end

  def public?(class) do
    class.state == :public
  end
end
