defmodule Athena.Education.Finder.CourseFinder do
  @moduledoc """
  Defines all the queries to find courses in the platform.
  It uses a query module to build the queries.
  """
  alias Athena.Education.Queries.CourseQuery
  alias Athena.Repo

  def featured_course do
    CourseQuery.build()
    |> CourseQuery.featured_course()
    |> Repo.one()
  end

  def not_featured_courses do
    CourseQuery.build()
    |> CourseQuery.not_featured_courses()
    |> Repo.all()
  end
end
