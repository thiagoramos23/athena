defmodule Athena.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Athena.Repo

  alias Athena.Education.Course
  alias Athena.Education.Class

  def course_factory(attrs \\ %{}) do
    {name, attrs} = Map.pop_lazy(attrs, :name, fn -> sequence(:name, &"#{&1}") end)

    course =
      %Course{
        name: name,
        slug: generate_slug_from(name),
        description: "Description",
        featured: false,
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      }

    merge_attributes(course, attrs)
  end

  def featured_course_factory do
    struct!(
      course_factory(),
      %{featured: true}
    )
  end

  def class_factory(attrs \\ %{}) do
    {name, attrs} = Map.pop_lazy(attrs, :name, fn -> sequence(:name, &"#{&1}") end)

    class =
      %Class{
        name: name,
        slug: generate_slug_from(name),
        description: "Description",
        class_length: 540,
        video_url: "https://vimeo.com/video/123456",
        thumbnail_url: "https://vimeo.com/video/123456",
        class_text: "This is a class text"
      }

    merge_attributes(class, attrs)
  end

  def generate_slug_from(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "-")
  end
end
