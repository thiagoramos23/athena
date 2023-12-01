defmodule AthenaWeb.Teachers.ClassLive.Index do
  use AthenaWeb, :live_view

  alias Athena.Education
  alias Athena.Education.Class
  alias AthenaWeb.Components.CardComponent
  alias AthenaWeb.Teachers.CourseLive.ClassFormComponent

  def mount(params, _session, socket) do
    current_user = socket.assigns.current_user

    socket =
      if current_user.teacher do
        socket
        |> assign(:teacher, current_user.teacher)
        |> assign(:show_modal, false)
        |> assign(
          :course,
          get_course_with_classes(current_user.teacher, params["course_slug"])
        )
      else
        socket
        |> push_navigate(~p"/")
      end

    {:ok, socket}
  end

  def handle_params(params, _uri, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  def handle_info({:created_class, class}, socket) do
    {:noreply, handle_class_created(class, socket)}
  end

  def handle_info({:updated_class, class}, socket) do
    {:noreply, handle_class_updated(class, socket)}
  end

  defp handle_class_created(class, socket) do
    socket
    |> put_flash(:info, "Aula criada com sucesso!")
    |> assign(:course, %{
      socket.assigns.course
      | classes: socket.assigns.course.classes ++ [class]
    })
    |> assign(:current_user, socket.assigns.current_user)
    |> assign(:teacher, socket.assigns.teacher)
    |> push_patch(to: ~p"/teachers/courses/#{socket.assigns.course.slug}")
  end

  defp handle_class_updated(_class, socket) do
    socket
    |> put_flash(:info, "Aula atualizada com sucesso!")
    |> push_navigate(to: ~p"/teachers/courses/#{socket.assigns.course.slug}")
  end

  defp apply_action(socket, :index, _params) do
    socket |> assign(:show_modal, false)
  end

  defp apply_action(socket, :edit, %{"class_slug" => class_slug}) do
    socket
    |> assign(:show_modal, true)
    |> assign(:class, Education.get_class_by_slug(class_slug))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:show_modal, true)
    |> assign(:class, %Class{})
  end

  defp get_course_with_classes(teacher, course_slug) do
    Education.get_teacher_course_by_slug(teacher.id, course_slug)
  end

  def render(assigns) do
    ~H"""
    <%= if @show_modal do %>
      <.modal
        id="create_class_modal"
        show={@show_modal}
        on_cancel={JS.navigate(~p"/teachers/courses/#{@course.slug}")}
      >
        <.live_component
          module={ClassFormComponent}
          id="create_class"
          class={@class}
          course={@course}
        />
      </.modal>
    <% end %>
    <div :if={!@course} class="text-2xl text-white">
      Curso não existe
    </div>
    <div :if={@course} class="mt-5">
      <h1 class="text-white text-2xl font-semibold">
        <%= @course.name %>
      </h1>
      <br />
      <div class="grid grid-cols-4">
        <CardComponent.add_new_item new_item_url={~p"/teachers/courses/#{@course.slug}/classes/new"} />
        <div :for={class <- @course.classes} class="pt-2 pl-4 w-full">
          <CardComponent.show
            item={class}
            item_description={class.summary}
            item_url={~p"/teachers/courses/#{@course.slug}/classes/#{class.slug}"}
            edit_item_url={~p"/teachers/courses/#{@course.slug}/classes/#{class.slug}/edit"}
          />
        </div>
      </div>
    </div>
    """
  end
end
