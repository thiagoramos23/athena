defmodule AthenaWeb.Teachers.CourseLive.Index do
  use AthenaWeb, :live_view

  alias Athena.Education
  alias AthenaWeb.Components.CardComponent

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user

    socket =
      if current_user.teacher do
        socket
        |> assign(:teacher, current_user.teacher)
        |> assign(:courses, teacher_courses(current_user.teacher))
        |> assign(:show_modal, false)
      else
        socket
        |> push_navigate(~p"/")
      end

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params), do: socket

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:show_modal, true)
  end

  defp teacher_courses(teacher) do
    Education.get_teacher_courses(teacher.id)
  end

  def render(assigns) do
    ~H"""
    <%= if @show_modal do %>
      <h1>Test</h1>
    <% else %>
      <div class="mt-5">
        <h1 class="text-white text-2xl font-semibold">Meus Cursos</h1>
        <br>
        <CardComponent.add_course new_course_url={~p"/teachers/courses/new"}/>
        <div :for={course <- @courses} class="mt-6 grid grid-cols-2 gap-x-4 gap-y-10 sm:gap-x-6 md:grid-cols-4 md:gap-y-0 lg:gap-x-8">
          <CardComponent.course course={course} course_url={~p"/teachers/courses/#{course.slug}"}/>
        </div>
      </div>
    <% end %>
    """
  end
end
