defmodule AthenaWeb.ClassesLive.Show do
  use AthenaWeb, :live_view

  require Logger

  alias Athena.Accounts.User
  alias Athena.Education
  alias AthenaWeb.MainLayout

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
      {:noreply, push_redirect(socket, to: ~p"/checkout")}
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

  defp maybe_associate_student_to_class(%{student: student} = user, class) do
    Education.associate_student_to_class(student, class)
    {:ok, student}
  end

  defp get_classes(%{"course_slug" => course_slug}, nil) do
    Education.get_classes(course_slug, nil)
  end

  defp get_classes(%{"course_slug" => course_slug}, %{student: student} = current_user) do
    Education.get_classes(course_slug, student.id)
  end

  defp get_class(classes, %{"class_slug" => class_slug}) do
    Enum.find(classes, &(&1.slug == class_slug))
  end
end
