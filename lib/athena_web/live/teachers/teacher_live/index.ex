defmodule AthenaWeb.Teachers.TeacherLive.Index do
  use AthenaWeb, :live_view

  alias AthenaWeb.Teachers.TeacherLive.FormComponent
  alias Athena.Education
  alias Athena.Education.Teacher

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(form: to_form(Education.change_teacher(%Teacher{})))}
  end

  def handle_info({:created_teacher, teacher}, socket) do
    {:noreply, handle_teacher_created(teacher, socket)}
  end

  defp handle_teacher_created(teacher, socket) do
    socket
    |> put_flash(:info, "Professor criado com sucesso!")
    |> assign(:teacher, teacher)
  end

  def render(assigns) do
    ~H"""
    <.live_component module={FormComponent} id="create_teacher" />
    """
  end
end
