defmodule AthenaWeb.Students.CoursesLive.Show do
  use AthenaWeb, :live_view
  alias Athena.Accounts.User
  alias Athena.Education

  alias AthenaWeb.MainLayout

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
    <MainLayout.show_course_with_classes
      course={@course}
      current_user={@current_user}
      paid_student={User.paid_student?(@current_user)}
    />
    """
  end
end
