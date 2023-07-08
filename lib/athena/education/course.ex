defmodule Athena.Education.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field(:name, :string)
    field(:description, :string)
    field(:featured, :boolean, default: false)

    timestamps()
  end

  @valid_keys [:name, :description, :featured]

  def changeset(course, attrs) do
    course
    |> cast(attrs, @valid_keys)
    |> validate_required(@valid_keys)
  end
end