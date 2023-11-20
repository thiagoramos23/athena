defmodule AthenaWeb.Students.CoursesLive.Index do
  use AthenaWeb, :live_view

  alias Athena.Accounts.User
  alias AthenaWeb.MainLayout
  alias Athena.Education

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(featured_course: get_featured_course())
     |> assign(courses: get_courses())}
  end

  defp get_featured_course do
    Education.featured_course(preload: [:classes])
  end

  defp get_courses do
    Education.not_featured_courses(preload: [:classes])
  end

  def render(assigns) do
    ~H"""
    <div>
      <MainLayout.headline />
      <div>
        <div class="font-sans font-bold text-blue-400">
          Destaque
        </div>
      </div>
      <div :if={@featured_course}>
        <MainLayout.show_course_with_classes course={@featured_course} current_user={@current_user} paid_student={User.paid_student?(@current_user)}/>
      </div>
      <div class="mt-10">
        <div class="font-sans font-bold text-blue-400">
          Cursos
        </div>
      </div>
      <div class="mt-10">
        <div :for={course <- @courses}>
          <MainLayout.show_course_with_classes course={course} current_user={@current_user} paid_student={User.paid_student?(@current_user)}/>
          <br/>
        </div>
      </div>
    </div>
    """
  end
end
