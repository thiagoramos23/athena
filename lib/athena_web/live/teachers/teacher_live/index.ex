defmodule AthenaWeb.Teachers.TeacherLive.Index do
  use AthenaWeb, :live_view

  alias AthenaWeb.Teachers.TeacherLive.FormComponent

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user

    socket =
      if current_user.teacher do
        socket
        |> assign(:teacher, current_user.teacher)
      else
        socket |> assign(:teacher, nil)
      end

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_info({:created_teacher, teacher}, socket) do
    {:noreply, handle_teacher_created(teacher, socket)}
  end

  defp apply_action(socket, :index, _params) do
    if socket.assigns.teacher do
      socket
      |> push_navigate(to: ~p"/teachers/courses")
    else
      socket
      |> push_navigate(to: ~p"/")
    end
  end

  defp apply_action(socket, :new, _params) do
    socket |> assign(:show_modal, true)
  end

  defp handle_teacher_created(teacher, socket) do
    socket
    |> put_flash(:info, "Cadastro criado com sucesso!")
    |> assign(:teacher, teacher)
    |> assign(:current_user, %{socket.assigns.current_user | teacher: teacher})
    |> push_patch(to: ~p"/teachers/courses")
  end

  def render(assigns) do
    ~H"""
    <.modal id="create_teacher_modal" show={@show_modal}>
      <.live_component module={FormComponent} id="create_teacher" current_user={@current_user} />
    </.modal>
    """
  end
end
