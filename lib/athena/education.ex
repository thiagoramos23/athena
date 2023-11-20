defmodule Athena.Education do
  @moduledoc """
  All the main functions for the education subdomain
  """
  require Logger

  import Ecto.Query

  alias Athena.Accounts.User
  alias Athena.Education.Class
  alias Athena.Education.Course
  alias Athena.Education.Finder.CourseFinder
  alias Athena.Education.Finder.ClassFinder
  alias Athena.Education.Student
  alias Athena.Education.StudentClass
  alias Athena.Education.StudentCourse
  alias Athena.Education.Teacher
  alias Athena.Repo

  defdelegate student_courses(student), to: CourseFinder
  defdelegate get_course_by_slug(course_slug), to: CourseFinder
  defdelegate get_course_by_id(course_id), to: CourseFinder

  def featured_course(opts) do
    featured_course = CourseFinder.featured_course(opts)

    if featured_course do
      classes = Enum.sort_by(featured_course.classes, & &1.id)
      %{featured_course | classes: classes}
    else
      featured_course
    end
  end

  def not_featured_courses(opts) do
    CourseFinder.not_featured_courses(opts)
    |> Enum.map(fn course ->
      if course do
        classes = Enum.sort_by(course.classes, & &1.id)
        %{course | classes: classes}
      else
        course
      end
    end)
  end

  def create_student(attrs) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  def associate_student_to_class(student, class) do
    Repo.transaction(fn ->
      do_associate_student_to_class(student, class)
      do_associate_student_to_course(student, class.course_id)
    end)
  end

  def complete_class(class, student) do
    student_class = Repo.get_by(StudentClass, class_id: class.id, student_id: student.id)

    student_class
    |> StudentClass.changeset(%{completed_at: DateTime.utc_now()})
    |> Repo.update()
    |> case do
      {:ok, _} ->
        :ok

      {:error, error} ->
        dbg()
        Logger.error(error)
        :ok
    end
  end

  def drop_class(class, student) do
    student_class = Repo.get_by(StudentClass, class_id: class.id, student_id: student.id)

    student_class
    |> StudentClass.changeset(%{completed_at: nil})
    |> Repo.update()
    |> case do
      {:ok, _} ->
        :ok

      {:error, error} ->
        dbg()
        Logger.error(error)
        :ok
    end
  end

  def can_see?(class, nil) do
    Class.public?(class)
  end

  def can_see?(class, user) do
    Class.public?(class) || User.student?(user)
  end

  def get_classes(course_slug, nil) do
    ClassFinder.call(course_slug: course_slug)
  end

  def get_class_by_slug(class_slug) do
    ClassFinder.get_by_slug(class_slug)
  end

  def get_class_by_id(class_id) do
    ClassFinder.get_by_id(class_id)
  end

  def get_classes(course_slug, student_id) do
    classes =
      ClassFinder.call(
        course_slug: course_slug,
        student_id: student_id
      )

    student_classes_by_class_id =
      Enum.map(classes, & &1.id)
      |> get_student_classes(student_id)
      |> Enum.group_by(& &1.class_id)

    classes
    |> Enum.map(fn class ->
      case student_classes_by_class_id[class.id] do
        [student_class] ->
          %{class | completed: !is_nil(student_class.completed_at)}

        nil ->
          class
      end
    end)
  end

  def create_teacher(params) do
    %Teacher{}
    |> Teacher.changeset(params)
    |> Repo.insert()
  end

  def change_teacher(teacher, attrs \\ %{}) do
    teacher
    |> Teacher.changeset(attrs)
  end

  def create_course(params) do
    %Course{}
    |> Course.changeset(params)
    |> Repo.insert()
  end

  def update_course(course, params) do
    course
    |> Course.changeset(params)
    |> Repo.update()
  end

  def change_course(course, attrs \\ %{}) do
    course
    |> Course.changeset(attrs)
  end

  def create_class(params) do
    %Class{}
    |> Class.changeset(params)
    |> Repo.insert()
  end

  def update_class(class, params) do
    class
    |> Class.changeset(params)
    |> Repo.update()
  end

  def change_class(class, attrs \\ %{}) do
    class
    |> Class.changeset(attrs)
  end

  def get_teacher_courses(teacher_id) do
    query =
      from course in Course,
        where: course.teacher_id == ^teacher_id,
        preload: [
          :teacher
        ],
        order_by: [asc: course.id]

    Repo.all(query)
  end

  def get_teacher_course_by_slug(teacher_id, course_slug) do
    query =
      from course in Course,
        where: course.teacher_id == ^teacher_id,
        where: course.slug == ^course_slug,
        preload: [
          :teacher,
          :classes
        ]

    Repo.one(query)
  end

  defp get_student_classes(classes_id, student_id) do
    query =
      from student_classes in StudentClass,
        where:
          student_classes.class_id in ^classes_id and student_classes.student_id == ^student_id

    Repo.all(query)
  end

  defp do_associate_student_to_class(student, class) do
    %StudentClass{}
    |> StudentClass.changeset(%{
      completed_at: nil,
      time: 0,
      student_id: student.id,
      class_id: class.id
    })
    |> Repo.insert(on_conflict: :nothing)
  end

  defp do_associate_student_to_course(student, course_id) do
    %StudentCourse{}
    |> StudentCourse.changeset(%{
      student_id: student.id,
      course_id: course_id
    })
    |> Repo.insert(on_conflict: :nothing)
  end
end
