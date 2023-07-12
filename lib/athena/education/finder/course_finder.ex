defmodule Athena.Education.Finder.CourseFinder do
  @moduledoc """
  Defines all the queries to find courses in the platform.
  It uses a query module to build the queries.
  """
  alias Athena.Education.Queries.CourseQuery
  alias Athena.Repo

  def featured_course(opts \\ []) do
    preloads = Keyword.get(opts, :preload, [])

    CourseQuery.build()
    |> CourseQuery.featured_course()
    |> Repo.one()
    |> Repo.preload(preloads)
  end

  def not_featured_courses(opts \\ []) do
    preloads = Keyword.get(opts, :preload, [])

    CourseQuery.build()
    |> CourseQuery.not_featured_courses()
    |> Repo.all()
    |> Repo.preload(preloads)
  end
end
