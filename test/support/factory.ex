defmodule Athena.Factory do
  use ExMachina.Ecto, repo: Athena.Repo

  alias Athena.Education.Course

  def featured_course_factory do
    %Course{
      name: sequence(:name, &"#{&1}"),
      description: "Description",
      featured: true,
      inserted_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end

  def course_factory do
    %Course{
      name: sequence(:name, &"#{&1}"),
      description: "Description",
      featured: false,
      inserted_at: NaiveDateTime.utc_now(),
      updated_at: NaiveDateTime.utc_now()
    }
  end
end
