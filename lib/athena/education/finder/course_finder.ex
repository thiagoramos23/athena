defmodule Athena.Education.Finder.CourseFinder do
  @moduledoc """
  Defines all the queries to find courses in the platform.
  It uses a query module to build the queries.
  """
  alias Athena.Education.Queries.CourseQuery
  alias Athena.Repo

  def get_course_by_slug(course_slug) do
    CourseQuery.build()
    |> CourseQuery.by_slug(course_slug)
    |> Repo.one()
    |> Repo.preload([:classes])
  end

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

  def student_courses(student) do
    CourseQuery.build()
    |> CourseQuery.for_student(student)
    |> Repo.all()
    |> Repo.preload([:classes])
  end
end
