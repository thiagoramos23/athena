defmodule Athena.Catalog.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :slug, Ecto.UUID, default: Ecto.UUID.autogenerate()
    field :cover_image_url, :string
    field :description, :string
    field :full_description, :string
    field :labels, :string
    field :name, :string
    field :slug_name, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :slug_name, :full_description, :description, :price, :cover_image_url, :labels])
    |> validate_required([:name, :slug_name, :full_description, :description, :price, :cover_image_url, :labels, :slug])
  end
end
