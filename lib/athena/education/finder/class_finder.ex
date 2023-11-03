defmodule Athena.Education.Finder.ClassFinder do
  @moduledoc """
  Defines all the queries to find classes in the platform.
  """
  import Ecto.Query

  alias Athena.Repo

  def call(opts \\ []) do
    build_query()
    |> filter(opts)
    |> order_by([class], asc: class.id, asc: class.inserted_at)
    |> Repo.all()
  end

  defp build_query() do
    from class in Athena.Education.Class,
      as: :class,
      preload: [:course]
  end

  defp filter(query, opts), do: Enum.reduce(opts, query, &filter_query/2)

  defp filter_query({:course_slug, course_slug}, query) do
    query
    |> join(:inner, [class: class], course in assoc(class, :course), as: :course)
    |> where([course: course], course.slug == ^course_slug)
  end

  defp filter_query({:student_id, nil}, query), do: query

  defp filter_query({:student_id, student_id}, query) do
    from class in query,
      left_join: students in assoc(class, :students),
      as: :students,
      where: is_nil(students.id) or students.id == ^student_id,
      preload: [
        students: students
      ]
  end

  defp filter_query(_params, query), do: query
end
