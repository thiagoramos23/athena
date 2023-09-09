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
  def public?(index) do
    if index == 0, do: :public, else: :private
  end
end

{:ok, featured_course} =
  %Course{}
  |> Course.changeset(%{
    name: "Elixir in Action",
    description: "Good course on ELixlir",
    slug: "elixir-in-action",
    featured: true
  })
  |> Repo.insert()

{:ok, normal_course} =
  %Course{}
  |> Course.changeset(%{
    name: "iOS for The Kids",
    description: "Best iOS content for your kids to learn how to program",
    slug: "ios-for-the-kids",
    featured: false
  })
  |> Repo.insert()

class_description = Earmark.as_html!(File.read!("priv/static/example.md"))

for i <- 0..5,
    course <- [featured_course, normal_course] do
  %Class{}
  |> Class.changeset(%{
    name: "How to start with elixir",
    slug: "how-to-start-with-#{course.slug}-#{i}",
    summary: "Learning how to start with the Elixir Language and become a millionaire",
    description: class_description,
    video_url: "https://player.vimeo.com/video/822796259?h=17a8f7232b&app_id=122963",
    thumbnail_url:
      "https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80",
    class_length: 540,
    course_id: course.id,
    state: Checks.public?(i)
  })
  |> Repo.insert()
end
