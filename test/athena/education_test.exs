defmodule Athena.EducationTest do
  use Athena.DataCase, async: true

  alias Athena.Education
  alias Athena.Education.Course
  alias Athena.Education.Teacher
  alias Athena.Repo

  describe "create_cousre/1" do
    test "creates a course with a teacher" do
      user = insert(:user)
      teacher = insert(:teacher, user: user)
      course_params = params_for(:course, teacher_id: teacher.id)

      assert {:ok, %Athena.Education.Course{} = course} = Education.create_course(course_params)

      assert %Course{teacher: %Teacher{id: teacher_id}} = Repo.preload(course, [:teacher])
      assert teacher_id == teacher.id
    end
  end

  describe "create_class/1" do
    test "creates a class" do
      course = insert(:course)
      attrs = params_for(:class, name: "New class", course: course)
      assert {:ok, class} = Education.create_class(attrs)
      assert class.name == "New class"
      assert class.slug == "new-class"
    end

    test "does not create a class with the same slug" do
      course = insert(:course)
      insert(:class, name: "teste", slug: "teste", course: course)
      attrs = params_for(:class, name: "teste", slug: "teste", course: course)
      {:error, %Ecto.Changeset{valid?: false, errors: errors}} = Education.create_class(attrs)

      assert errors == [
               slug:
                 {"has already been taken",
                  [constraint: :unique, constraint_name: "classes_slug_index"]}
             ]
    end
  end
end
