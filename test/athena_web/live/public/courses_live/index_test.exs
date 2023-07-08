defmodule AthenaWeb.Public.CousesLive.IndexTest do
  use AthenaWeb.ConnCase

  import Phoenix.LiveViewTest

  setup do
    featured_course = insert(:featured_course, name: "Featured Course")
    elixir_course = insert(:course, name: "Elixir Course")
    swift_course = insert(:course, name: "Swift Course")

    %{featured_course: featured_course, courses: [elixir_course, swift_course]}
  end

  test "will show featured courses", %{conn: conn, featured_course: featured_course} do
    disconnected = conn |> get(~p"/")
    assert html_response(disconnected, 200) =~ "Destaque"

    {:ok, _view, html} = live(disconnected)
    assert html =~ featured_course.name
    assert html =~ featured_course.description

    # TODO: Check if the classes for the featured course is being showed
  end

  test "will show all the other courses", %{conn: conn, courses: courses} do
    disconnected = conn |> get(~p"/")
    assert html_response(disconnected, 200) =~ "Cursos"

    {:ok, _view, html} = live(disconnected)

    for course <- courses do
      assert html =~ course.name
      assert html =~ course.description
    end

    # TODO: Check if the classes for the courses are being showed
  end
end
