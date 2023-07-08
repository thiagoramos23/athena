defmodule Athena.Education.Class do
  use Ecto.Schema
  import Ecto.Changeset

  schema "classes" do
    field(:name, :string)
    field(:description, :string)
    field(:class_length, :integer)
    field(:video_url, :string)
    field(:class_text, :string)
  end

  @valid_keys [:name, :description, :class_length, :video_url, :class_text]

  def changeset(class, attrs) do
    class
    |> cast(attrs, @valid_keys)
    |> validate_required(@valid_keys)
  end
end
