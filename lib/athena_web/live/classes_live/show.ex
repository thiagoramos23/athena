defmodule AthenaWeb.ClassesLive.Show do
  use AthenaWeb, :live_view

  alias Athena.Accounts.User
  alias Athena.Education
  alias AthenaWeb.MainLayout

  def mount(params, _session, socket) do
    class = get_class(params)
    classes = get_classes(params)

    {
      :ok,
      socket
      |> assign(:classes, classes)
      |> assign(:class, class)
      |> assign(:total_class_count, length(classes))
    }
  end

  def handle_params(params, _url, socket) do
    class = socket.assigns.class
    user = socket.assigns.current_user

    IO.inspect(Education.can_see?(class, user), label: "TESTING USER CAN SEE")

    if Education.can_see?(class, user) do
      {:noreply, socket}
    else
      {:noreply, push_redirect(socket, to: ~p"/checkout")}
    end
  end

  defp get_classes(%{"course_slug" => course_slug}) do
    Education.get_classes(course_slug)
  end

  defp get_class(%{"class_slug" => class_slug}) do
    Education.get_class(class_slug)
  end
end
