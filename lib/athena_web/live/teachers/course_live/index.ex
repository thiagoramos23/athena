defmodule AthenaWeb.Teachers.CourseLive.Index do
  use AthenaWeb, :live_view

  alias Athena.Education
  alias Athena.Education.Course
  alias AthenaWeb.Components.CardComponent
  alias AthenaWeb.Teachers.CourseLive.CourseFormComponent

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user

    socket =
      if current_user.teacher do
        socket
        |> assign(:teacher, current_user.teacher)
        |> assign(:courses, teacher_courses(current_user.teacher))
      else
        socket
        |> push_navigate(~p"/")
      end

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_info({:created_course, course}, socket) do
    {:noreply, handle_course_created(course, socket)}
  end

  defp handle_course_created(course, socket) do
    socket
    |> put_flash(:info, "Curso criado com sucesso!")
    |> assign(:course, course)
    |> assign(:current_user, socket.assigns.current_user)
    |> push_navigate(to: ~p"/teachers/courses/#{course.slug}")
  end

  defp apply_action(socket, :index, _params) do
    socket |> assign(:show_modal, false)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:show_modal, true)
    |> assign(:course, %Course{})
  end

  defp teacher_courses(teacher) do
    Education.get_teacher_courses(teacher.id)
  end

  def render(assigns) do
    ~H"""
    <%= if @show_modal do %>
      <.modal id="create_course_modal" show={@show_modal}>
        <.live_component module={CourseFormComponent} id="create_course" teacher={@teacher} course={@course}/>
      </.modal>
    <% end %>
    <div class="mt-5">
      <h1 class="text-white text-2xl font-semibold">Cursos que criados pelo professor <%= @teacher.name %></h1>
      <br>
      <div class="grid grid-cols-4">
        <CardComponent.add_new_item new_item_url={~p"/teachers/courses/new"}/>
        <div :for={course <- @courses} class="pt-2 pl-4 w-full">
          <CardComponent.show item={course} item_description={course.description} item_url={~p"/teachers/courses/#{course.slug}"}/>
        </div>
      </div>
    </div>
    """
  end
end
