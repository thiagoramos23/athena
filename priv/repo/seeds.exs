# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Athena.Repo.insert!(%Athena.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Athena.Education.Course
alias Athena.Education.Class
alias Athena.Repo

defmodule Checks do
  def public?(index, total_classes) do
    cond do
      index == 0 ->
        :public

      index == total_classes ->
        :soon

      true ->
        :private
    end
  end
end

{:ok, user} =
  Athena.Accounts.register_user(%{email: "thiago@thiago.com", password: "123123123123"})

{:ok, teacher} =
  Athena.Education.create_teacher(%{name: "Thiago", email: "thiago@thiago.com", user_id: user.id})

{:ok, _permission} =
  %Athena.Security.Permission{}
  |> Athena.Security.Permission.changeset(%{
    user_id: user.id,
    name: "admin"
  })
  |> Repo.insert()

{:ok, featured_course} =
  %Course{}
  |> Course.changeset(%{
    name: "Elixir in Action",
    description: "Good course on ELixlir",
    slug: "elixir-in-action",
    thumbnail_url:
      "https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80",
    featured: true,
    teacher_id: teacher.id
  })
  |> Repo.insert()

{:ok, normal_course} =
  %Course{}
  |> Course.changeset(%{
    name: "iOS for The Kids",
    description: "Best iOS content for your kids to learn how to program",
    slug: "ios-for-the-kids",
    thumbnail_url:
      "https://images.unsplash.com/photo-1508830524289-0adcbe822b40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2025&q=80",
    featured: false,
    teacher_id: teacher.id
  })
  |> Repo.insert()

{:ok, another_course} =
  %Course{}
  |> Course.changeset(%{
    name: "Rust is the new kid on the block",
    description: "Best Rust course you will ever encounter in your entire life",
    slug: "rust-to-save-the-world",
    thumbnail_url:
      "https://images.unsplash.com/photo-1508830524289-0adcbe822b40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2025&q=80",
    featured: false,
    teacher_id: teacher.id
  })
  |> Repo.insert()

{:ok, fourth_course} =
  %Course{}
  |> Course.changeset(%{
    name: "Rust is the new kid on the block",
    description: "Best Rust course you will ever encounter in your entire life",
    slug: "test-grid",
    thumbnail_url:
      "https://images.unsplash.com/photo-1508830524289-0adcbe822b40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2025&q=80",
    featured: false,
    teacher_id: teacher.id
  })
  |> Repo.insert()

{:ok, fifth_course} =
  %Course{}
  |> Course.changeset(%{
    name: "Rust is the new kid on the block",
    description: "Best Rust course you will ever encounter in your entire life",
    slug: "test-grid-again",
    thumbnail_url:
      "https://images.unsplash.com/photo-1508830524289-0adcbe822b40?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2025&q=80",
    featured: false,
    teacher_id: teacher.id
  })
  |> Repo.insert()

class_description = Earmark.as_html!(File.read!("priv/static/example.md"))

for i <- 0..5,
    course <- [featured_course, normal_course, another_course, fourth_course, fifth_course] do
  %Class{}
  |> Class.changeset(%{
    name: "How to start with elixir #{i}",
    slug: "how-to-start-with-#{course.slug}-#{i}",
    summary:
      "Learning how to start with the Elixir Language and become a millionaire, forget about working for others and work for yourself",
    description: class_description,
    video_url: "https://www.youtube.com/embed/gYu960pVWis?si=mUKGqGmbQ29ffPhp",
    thumbnail_url:
      "https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80",
    class_length: 540,
    course_id: course.id,
    state: Checks.public?(i, 5)
  })
  |> Repo.insert()
end
