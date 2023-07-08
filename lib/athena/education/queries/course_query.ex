defmodule Athena.Education.Queries.CourseQuery do
  @moduledoc """
  Defines queries that will give information from courses
  """
  import Ecto.Query
  alias Athena.Education.Course

  def build do
    from course in Course,
      as: :course
  end

  def featured_course(query) do
    query
    |> where([course: course], course.featured == true)
  end

  def not_featured_courses(query) do
    query
    |> where([course: course], course.featured == false)
  end
end
