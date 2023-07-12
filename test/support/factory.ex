defmodule Athena.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Athena.Repo

  alias Athena.Education.Course
  alias Athena.Education.Class

  def course_factory do
    name = sequence(:name, &"#{&1}")

    %Course{
      name: name,
      slug: String.replace(name, " ", "-"),
      description: "Description",
      featured: false,
      inserted_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end

  def featured_course_factory do
    struct!(
      course_factory(),
      %{featured: true}
    )
  end

  def class_factory do
    name = sequence(:name, &"#{&1}")

    %Class{
      name: name,
      slug: String.replace(name, " ", "-"),
      description: "Description",
      class_length: 540,
      video_url: "https://vimeo.com/video/123456",
      thumbnail_url: "https://vimeo.com/video/123456",
      class_text: "This is a class text"
    }
  end
end
