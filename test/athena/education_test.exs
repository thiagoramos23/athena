defmodule Athena.EducationTest do
  use Athena.DataCase, async: true

  alias Athena.Education
  alias Athena.Education.Course
  alias Athena.Education.Teacher
  alias Athena.Repo

  describe "create_cousre/2" do
    test "creates a course with a teacher" do
      user = insert(:user)
      teacher = insert(:teacher, user: user)
      course_params = params_for(:course, teacher_id: teacher.id)

      assert {:ok, %Athena.Education.Course{} = course} = Education.create_course(course_params)

      assert %Course{teacher: %Teacher{id: teacher_id}} = Repo.preload(course, [:teacher])
      assert teacher_id == teacher.id
    end
  end
end
