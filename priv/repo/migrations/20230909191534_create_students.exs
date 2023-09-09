defmodule Athena.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add(:user_id, references(:users, on_delete: :nothing), null: false)
      add(:state, :string, default: "paid")
    end

    create index(:students, [:user_id])
    create index(:students, [:state])
  end
end
