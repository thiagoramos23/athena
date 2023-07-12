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

alias Athena.Education
alias Athena.Education.Course
alias Athena.Education.Class
alias Athena.Repo

{:ok, course} =
  %Course{}
  |> Course.changeset(%{
    name: "Elixir in Action",
    description: "Good course on ELixlir",
    slug: "elixir-in-action",
    featured: true
  })
  |> Repo.insert()

for i <- 0..5 do
  %Class{}
  |> Class.changeset(%{
    name: "How to start with elixir",
    slug: "how-to-start-with-elixir-#{i}",
    description: "Description",
    video_url: "https://player.vimeo.com/video/822796259?h=17a8f7232b&app_id=122963",
    thumbnail_url:
      "https://images.unsplash.com/photo-1582053433976-25c00369fc93?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=512&q=80",
    class_text: "This is a text for the main section when showing the class",
    class_length: 540,
    course_id: course.id
  })
  |> Repo.insert()
end
