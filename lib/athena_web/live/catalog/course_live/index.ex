defmodule AthenaWeb.Catalog.CourseLive.Index do
  use AthenaWeb, :live_view

  alias Athena.Catalog
  alias AthenaWeb.Catalog.Component.CourseComponent

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign_courses()}
  end

  defp assign_courses(socket) do
    assign(socket, :courses, Catalog.list_courses())
  end
end
