defmodule AthenaWeb.Catalog.CourseLive.Show do
  use AthenaWeb, :live_view

  alias Athena.Catalog
  alias AthenaWeb.Catalog.Component.CourseComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"slug_name" => slug_name} = _params, _uri, socket) do
    {:noreply,
     socket
     |> assign_courses()
     |> assign_course(slug_name)}
  end

  defp assign_courses(socket) do
    assign(socket, :courses, get_courses())
  end

  defp assign_course(socket, slug_name) do
    assign(socket, :course, get_course(socket, slug_name))
  end

  defp get_courses() do
    Catalog.list_courses()
  end

  defp get_course(socket, slug_name) do
    socket.assigns.courses
    |> Enum.find(fn course -> course.slug_name == slug_name end)
  end
end
