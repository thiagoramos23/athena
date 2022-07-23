defmodule Athena.CatalogTest do
  use Athena.DataCase

  alias Athena.Catalog

  describe "courses" do
    alias Athena.Catalog.Course

    @invalid_attrs %{
      cover_image_url: nil,
      full_description: nil,
      description: nil,
      labels: nil,
      name: nil,
      slug_name: nil,
      price: nil
    }

    test "list_courses/0 returns all courses" do
      course = insert(:course)
      assert Catalog.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = insert(:course)
      assert Catalog.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      valid_attrs = %{
        cover_image_url: "some cover_image_url",
        description: "some description",
        labels: "some labels",
        name: "some name",
        slug_name: "some-name",
        full_description: "full description",
        price: 42
      }

      assert {:ok, %Course{} = course} = Catalog.create_course(valid_attrs)
      assert course.cover_image_url == "some cover_image_url"
      assert course.description == "some description"
      assert course.labels == "some labels"
      assert course.name == "some name"
      assert course.slug_name == "some-name"
      assert course.full_description == "full description"
      assert course.price == 42
    end

    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = insert(:course)

      update_attrs = %{
        cover_image_url: "some updated cover_image_url",
        description: "some updated description",
        full_description: "some updated full description",
        labels: "some updated labels",
        name: "some updated name",
        slug_name: "some-updated-name",
        price: 43
      }

      assert {:ok, %Course{} = course} = Catalog.update_course(course, update_attrs)
      assert course.cover_image_url == "some updated cover_image_url"
      assert course.description == "some updated description"
      assert course.full_description == "some updated full description"
      assert course.labels == "some updated labels"
      assert course.name == "some updated name"
      assert course.slug_name == "some-updated-name"
      assert course.price == 43
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = insert(:course)
      assert {:error, %Ecto.Changeset{}} = Catalog.update_course(course, @invalid_attrs)
      assert course == Catalog.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = insert(:course)
      assert {:ok, %Course{}} = Catalog.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = insert(:course)
      assert %Ecto.Changeset{} = Catalog.change_course(course)
    end
  end
end
