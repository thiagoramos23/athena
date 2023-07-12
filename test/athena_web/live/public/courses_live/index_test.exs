defmodule AthenaWeb.Public.CousesLive.IndexTest do
  use AthenaWeb.ConnCase

  import Phoenix.LiveViewTest

  setup do
    class1 = build(:class, name: "Class 1", description: "Description 1")
    class2 = build(:class, name: "Class 2", description: "Description 2")
    classes = [class1, class2]
    featured_course = insert(:featured_course, name: "Featured Course", classes: classes)
    elixir_course = insert(:course, name: "Elixir Course", classes: classes)
    swift_course = insert(:course, name: "Swift Course", classes: classes)

    %{featured_course: featured_course, courses: [elixir_course, swift_course]}
  end

  test "will show featured courses", %{conn: conn, featured_course: featured_course} do
    disconnected = conn |> get(~p"/")
    assert html_response(disconnected, 200) =~ "Destaque"

    [class1, class2] = featured_course.classes

    {:ok, _view, html} = live(disconnected)
    assert html =~ featured_course.name
    assert html =~ featured_course.description
    assert html =~ class1.name
    assert html =~ class1.description
    assert html =~ class1.thumbnail_url
    assert html =~ class2.name
    assert html =~ class2.thumbnail_url
    assert html =~ class2.description
  end

  test "will show all the other courses", %{conn: conn, courses: courses} do
    disconnected = conn |> get(~p"/")
    assert html_response(disconnected, 200) =~ "Cursos"

    {:ok, _view, html} = live(disconnected)

    for course <- courses do
      [class1, class2] = course.classes
      assert html =~ course.name
      assert html =~ course.description
      assert html =~ class1.name
      assert html =~ class1.description
      assert html =~ class1.thumbnail_url
      assert html =~ class2.name
      assert html =~ class2.description
      assert html =~ class2.thumbnail_url
    end
  end
end
