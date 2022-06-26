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
