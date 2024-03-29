defmodule AthenaWeb.Students.MyCoursesLive.Index do
  use AthenaWeb, :live_view
  alias AthenaWeb.MainLayout
  alias Athena.Education

  def mount(_params, _session, socket) do
    current_user = socket.assigns.current_user
    {:ok, assign(socket, my_courses: Education.student_courses(current_user.student))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="mt-10">
        <div class="font-sans text-3xl font-bold text-blue-400">
          Meus Cursos
        </div>
      </div>
      <div class="mt-10 md:flex md:space-x-8">
        <div :for={course <- @my_courses}>
          <div class="mb-10">
            <MainLayout.show_course course={course} />
          </div>
        </div>
      </div>
    </div>
    """
  end
end
