defmodule AthenaWeb.Teachers.CourseLive.Show do
  use AthenaWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-white">Show Course</h1>
    """
  end
end
