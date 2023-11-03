defmodule Athena.Factory do
  @moduledoc false
  use ExMachina.Ecto, repo: Athena.Repo

  alias Athena.Accounts.User
  alias Athena.Education.Course
  alias Athena.Education.Class
  alias Athena.Education.Teacher

  def course_factory(attrs \\ %{}) do
    {name, attrs} = Map.pop_lazy(attrs, :name, fn -> sequence(:name, &"#{&1}") end)

    course =
      %Course{
        name: name,
        slug: generate_slug_from(name),
        description: "Description",
        featured: false,
        cover_url: "cover_url",
        inserted_at: NaiveDateTime.utc_now(),
        updated_at: NaiveDateTime.utc_now()
      }

    merge_attributes(course, attrs)
  end

  def featured_course_factory do
    struct!(
      course_factory(),
      %{featured: true}
    )
  end

  def class_factory(attrs \\ %{}) do
    {name, attrs} = Map.pop_lazy(attrs, :name, fn -> sequence(:name, &"#{&1}") end)

    class =
      %Class{
        name: name,
        slug: generate_slug_from(name),
        summary: "Description",
        class_length: 540,
        video_url: "https://vimeo.com/video/123456",
        thumbnail_url: "https://vimeo.com/video/123456",
        state: :public,
        description: "This is a class text"
      }

    merge_attributes(class, attrs)
  end

  def user_factory(attrs \\ %{}) do
    {password, attrs} = Map.pop_lazy(attrs, :password, fn -> "hello_world" end)

    {email, attrs} =
      Map.pop_lazy(attrs, :email, fn -> "user#{System.unique_integer()}@example.com" end)

    hashed_password = Argon2.hash_pwd_salt(password)

    user =
      %User{
        email: email,
        hashed_password: hashed_password
      }

    merge_attributes(user, attrs)
  end

  def teacher_factory(attrs \\ %{}) do
    {name, attrs} = Map.pop_lazy(attrs, :name, fn -> sequence(:name, &"#{&1}") end)
    {email, attrs} = Map.pop_lazy(attrs, :email, fn -> sequence(:email, &"#{&1}@gmail.com") end)

    teacher =
      %Teacher{
        name: name,
        email: email,
        state: :active,
        user: build(:user)
      }

    merge_attributes(teacher, attrs)
  end

  def generate_slug_from(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "-")
  end
end
