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

Code.require_file("test/support/fixtures/accounts_fixtures.ex")

# Add a user
Athena.AccountsFixtures.user_fixture(%{email: "test@test.com", password: "123123123123123"})

Athena.Catalog.create_course(%{
  description: "This course will teach you how to be a better ios developer",
  cover_image_url: "/images/ios.jpg",
  name: "iOS for the Future",
  labels: "iOS, mobile",
  price: 9999
})

Athena.Catalog.create_course(%{
  description: "This course will let you understand the basics of elixir",
  cover_image_url: "/images/elixir.jpg",
  name: "Learn Elixir with Me",
  labels: "elixir, language",
  price: 9999
})

Athena.Catalog.create_course(%{
  description: "This course will make you the best with Phoenix Framework",
  cover_image_url: "/images/phoenix-course.jpg",
  name: "Phoenix Framework from zero to hero",
  labels: "elixir, language",
  price: 9999
})
