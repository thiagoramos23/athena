defmodule AthenaWeb.Public.ClassesLive.Show do
  use AthenaWeb, :live_view
  alias AthenaWeb.MainLayout

  alias Athena.Education

  def mount(params, _session, socket) do
    classes = get_classes(params)

    {
      :ok,
      socket
      |> assign(:classes, classes)
      |> assign(:class, get_class(params))
      |> assign(:total_class_count, length(classes))
    }
  end

  defp get_classes(%{"course_slug" => course_slug}) do
    Education.get_classes(course_slug)
  end

  defp get_class(%{"class_slug" => class_slug}) do
    Education.get_class(class_slug)
  end
end
