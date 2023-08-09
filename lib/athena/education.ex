defmodule Athena.Education do
  @moduledoc """
  All the main functions for the education subdomain
  """
  import Ecto.Query
  alias Athena.Education.Finder.CourseFinder
  alias Athena.Repo

  defdelegate featured_course(opts), to: CourseFinder
  defdelegate not_featured_courses(opts), to: CourseFinder

  def get_class(class_slug) do
    Repo.get_by(Athena.Education.Class, slug: class_slug)
    |> Repo.preload([:course])
  end

  def get_classes(course_slug) do
    query =
      from classes in Athena.Education.Class,
        join: courses in assoc(classes, :course),
        where: courses.slug == ^course_slug

    Repo.all(query)
  end
end
