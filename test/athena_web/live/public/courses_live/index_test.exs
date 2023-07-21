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

    {:ok, view, html} = live(disconnected)
    assert html =~ featured_course.name
    assert html =~ featured_course.description
    assert html =~ class1.name
    assert html =~ class1.description
    assert html =~ class2.name
    assert html =~ class2.description

    for thumbnail_url <- [class1.thumbnail_url, class2.thumbnail_url] do
      course_image = element(view, ~s(img[src*="#{thumbnail_url}"]))
      assert has_element?(course_image)
    end
  end

  test "will show all the other courses", %{conn: conn, courses: courses} do
    disconnected = conn |> get(~p"/")
    assert html_response(disconnected, 200) =~ "Cursos"

    {:ok, view, html} = live(disconnected)

    for course <- courses do
      [class1, class2] = course.classes
      assert html =~ course.name
      assert html =~ course.description
      assert html =~ class1.name
      assert html =~ class1.description
      assert html =~ class2.name
      assert html =~ class2.description

      for thumbnail_url <- [class1.thumbnail_url, class2.thumbnail_url] do
        course_image = element(view, ~s(img[src*="#{thumbnail_url}"]))
        assert has_element?(course_image)
      end
    end
  end

  test "user clicks in a class will send the user to the show class page", %{
    conn: conn,
    featured_course: featured_course
  } do
    class =
      insert(:class,
        name: "Class for featured course",
        description: "Description 1",
        course: featured_course
      )

    {:ok, view, _html} = live(conn, ~p"/")

    view
    |> element("##{class.slug}")
    |> render_click()

    {path, _flash} = assert_redirect(view)
    assert path == ~p"/courses/#{featured_course.slug}/classes/#{class.slug}"
  end
end
