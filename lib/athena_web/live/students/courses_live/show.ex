defmodule AthenaWeb.CoursesLive.Show do
  use AthenaWeb, :live_view
  alias AthenaWeb.MainLayout
  alias Athena.Education

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, %{"course_slug" => course_slug}) do
    course = Education.get_course_by_slug(course_slug)
    assign(socket, :course, course)
  end

  def render(assigns) do
    ~H"""
    <MainLayout.show_course_with_classes course={@course} />
    """
  end
end
