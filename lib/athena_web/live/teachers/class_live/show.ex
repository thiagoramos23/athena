defmodule AthenaWeb.Teachers.ClassLive.Show do
  use AthenaWeb, :live_view

  # alias Athena.Education
  # alias Athena.Education.Class
  # alias AthenaWeb.Components.CardComponent
  # alias AthenaWeb.Teachers.CourseLive.ClassFormComponent

  def mount(params, _session, socket) do
    current_user = socket.assigns.current_user

    socket =
      if current_user.teacher do
        socket
        |> assign(:teacher, current_user.teacher)
        |> assign(:show_modal, false)
      else
        socket
        |> push_navigate(~p"/")
      end

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>TESTE</div>
    """
  end
end
