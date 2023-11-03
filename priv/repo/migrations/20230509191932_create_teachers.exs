defmodule Athena.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add(:user_id, references(:users, on_delete: :nothing), null: false)
      add(:name, :citext, null: false)
      add(:email, :citext, null: false)
      add(:state, :string, default: "active")

      timestamps()
    end

    create index(:teachers, [:user_id])
    create index(:teachers, [:state])
    create unique_index(:teachers, [:email])
  end
end
