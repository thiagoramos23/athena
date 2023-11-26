defmodule Athena.Education.Finder.CourseFinderTest do
  use Athena.DataCase, async: true

  alias Athena.Education.Finder.CourseFinder

  describe "featured_course/0" do
    test "returns the featured course for the platform" do
      featured_course = insert(:featured_course)
      _not_featured_course = insert(:course)

      course_returned = CourseFinder.featured_course()
      assert featured_course.id == course_returned.id
    end

    test "returns the classes in the course" do
      course = insert(:featured_course)
      _classes = insert_list(5, :class, course: course)

      course_returned = CourseFinder.featured_course(preload: [:classes])
      assert course_returned.id == course.id
      assert length(course_returned.classes) == 5
    end
  end

  describe "not_featured_courses/0" do
    test "returns all courses that are not featured" do
      _featured_course = insert(:featured_course)
      not_featured_course1 = insert(:course)
      not_featured_course2 = insert(:course)

      assert [not_featured_course1.id, not_featured_course2.id] ==
               CourseFinder.not_featured_courses() |> Enum.sort_by(& &1.id) |> Enum.map(& &1.id)
    end

    test "returns the classes in the course" do
      course = insert(:course)
      insert_list(5, :class, course: course)

      assert [result] = CourseFinder.not_featured_courses(preload: [:classes])
      assert result.id == course.id
      assert length(result.classes) == 5
    end
  end
end
