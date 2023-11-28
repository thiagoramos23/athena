defmodule AthenaWeb.Students.ClassesLive.Show do
  use AthenaWeb, :live_view

  require Logger

  alias Athena.Education

  def mount(params, _session, socket) do
    current_user = socket.assigns.current_user
    classes = get_classes(params, current_user)
    class = get_class(classes, params)
    {:ok, student} = maybe_associate_student_to_class(current_user, class)

    {
      :ok,
      socket
      |> assign(:student, student)
      |> stream(:classes, classes)
      |> assign(:class, class)
      |> assign(:total_class_count, length(classes))
    }
  end

  def handle_params(_params, _url, socket) do
    class = socket.assigns.class
    user = socket.assigns.current_user

    if Education.can_see?(class, user) do
      {:noreply, socket}
    else
      # TODO: Check if the class is only private or if it's paid.
      # only send to checkout if the class is paid.
      {:noreply, push_navigate(socket, to: ~p"/checkout")}
    end
  end

  def handle_event(
        "toggle_complete_class",
        _,
        %{assigns: %{student: student, class: class}} = socket
      )
      when is_struct(student) do
    if class.completed do
      Education.drop_class(class, student)
      class = %{class | completed: false}

      {:noreply,
       socket
       |> assign(:class, class)
       |> stream_insert(:classes, class)}
    else
      Education.complete_class(class, student)
      class = %{class | completed: true}

      {:noreply,
       socket
       |> assign(:class, class)
       |> stream_insert(:classes, class)}
    end
  end

  def handle_event("toggle_complete_class", _params, socket) do
    {:noreply, socket}
  end

  defp maybe_associate_student_to_class(nil, _class), do: {:ok, nil}

  defp maybe_associate_student_to_class(%{student: student}, class) do
    Education.associate_student_to_class(student, class)
    {:ok, student}
  end

  defp get_classes(%{"course_slug" => course_slug}, nil) do
    Education.get_classes(course_slug, nil)
  end

  defp get_classes(%{"course_slug" => course_slug}, %{student: student}) do
    Education.get_classes(course_slug, student.id)
  end

  defp get_class(classes, %{"class_slug" => class_slug}) do
    Enum.find(classes, &(&1.slug == class_slug))
  end

  def render(assigns) do
    ~H"""
    <div class="mx-auto text-center text-gray-200 max-w-7xl">
      <div class="w-full aspect-video">
        <div style="padding:50.25% 0 0 0;position:relative;">
          <iframe
            src={@class.video_url}
            frameborder="0"
            allow="autoplay; fullscreen; picture-in-picture"
            style="position:absolute;left:0;right:0;top:0;width:100%;height:100%;"
          />
        </div>
      </div>
      <div class="flex justify-between md:max-w-6xl mx-auto mt-12 flex-items">
        <div class="flex flex-col justify-start md:w-3/5 flex-items">
          <div class="flex flex-col items-start text-3xl antialiased font-semibold flex-items">
            <div class="flex justify-between">
              <%= @class.name %>
              <%= if @current_user do %>
                <.button
                  :if={@class.completed}
                  class="ml-6 bg-green-900 cursor-default"
                  phx-click="toggle_complete_class"
                >
                  Aula completada
                </.button>
                <.button
                  :if={not @class.completed}
                  class="ml-6 text-black bg-green-600"
                  phx-click="toggle_complete_class"
                >
                  Completar Aula
                </.button>
              <% end %>
            </div>
            <span class="mt-4 text-lg font-normal">
              <%= @class.summary %>
            </span>
          </div>
          <div class="mt-12 text-left prose invert">
            <%= raw(@class.description) %>
          </div>
        </div>

        <div class="hidden md:block flex flex-col items-start w-2/5 ml-16 flex-items">
          <div class="flex flex-row mb-4 font-semibold text-md">
            <%= @class.course.name %>
            <span class="text-sm pt-0.5 pl-4 font-normal text-gray-500">
              <%= @total_class_count %> lessons
            </span>
          </div>
          <div
            id="list_classes"
            class="flex flex-col justify-between px-3 py-2 rounded"
            phx-update="stream"
          >
            <div :for={{class_id, class} <- @streams.classes} id={class_id}>
              <.link navigate={~p"/courses/#{@class.course.slug}/classes/#{class.slug}"}>
                <div class={[
                  "flex text-gray-500 flex-items mb-2 p-1 hover:bg-gray-800/50",
                  @class.slug == class.slug && "bg-gray-300 bg-opacity-10 p-2 rounded-md"
                ]}>
                  <.icon
                    :if={not class.completed}
                    name="hero-check-circle"
                    class="mt-[1.5px] mr-4 text-gray-500"
                  />
                  <.icon
                    :if={class.completed}
                    name="hero-check-circle"
                    class="mt-1 mr-4 text-green-500"
                  />
                  <div class="text-gray-200 text-md">
                    <%= class.name %>
                  </div>
                  <div class="text-sm text-gray-500 mt-[1px] ml-auto">
                    <.time_formatted time={class.class_length} />
                  </div>
                </div>
              </.link>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
