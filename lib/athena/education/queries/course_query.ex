defmodule Athena.Education.Queries.CourseQuery do
  @moduledoc """
  Defines queries that will give information from courses
  """
  import Ecto.Query
  alias Athena.Education.Course

  def build do
    from course in Course,
      as: :course,
      order_by: [asc: course.id]
  end

  def by_slug(query, slug) do
    query
    |> where([course: course], course.slug == ^slug)
  end

  def featured_course(query) do
    query
    |> where([course: course], course.featured == true)
  end

  def not_featured_courses(query) do
    query
    |> where([course: course], course.featured == false)
  end

  def for_student(query, student) do
    query
    |> join(:inner, [course], students in assoc(course, :students), as: :students)
    |> where([students: students], students.id == ^student.id)
  end
end
