defmodule Athena.Security.Permission do
  @moduledoc """
  Schema for security permissions.
  This schema is responsible to set roles for the permissions of the platform.
  Most common now are: :admin, :user
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "permissions" do
    field :name, :string
    field :user_id, :id

    timestamps()
  end

  @required_fields [:user_id, :name]

  @doc false
  def changeset(permission, attrs) do
    permission
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end

  def admin_permission?(permission) do
    permission.name == "admin"
  end
end
