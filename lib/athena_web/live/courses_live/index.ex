defmodule AthenaWeb.CoursesLive.Index do
  use AthenaWeb, :live_view
  alias AthenaWeb.MainLayout
  alias Athena.Education

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(featured_course: get_featured_course())
     |> assign(courses: get_courses())}
  end

  defp get_featured_course do
    Education.featured_course(preload: [:classes])
  end

  defp get_courses do
    Education.not_featured_courses(preload: [:classes])
  end
end
