defmodule Athena.Repo.Migrations.CreateTeachers do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add(:user_id, references(:users, on_delete: :nothing), null: false)
      add(:state, :string, default: "active")
    end

    create index(:teachers, [:user_id])
    create index(:teachers, [:state])
  end
end
