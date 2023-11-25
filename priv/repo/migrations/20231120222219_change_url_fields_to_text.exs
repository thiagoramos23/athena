defmodule Athena.Repo.Migrations.ChangeUrlFieldsToText do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      modify(:thumbnail_url, :text, from: :string)
    end

    alter table(:classes) do
      modify(:thumbnail_url, :text, from: :string)
    end
  end
end
