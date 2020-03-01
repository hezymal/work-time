defmodule WorktimeServer.Repo.Migrations.CreateTimeUnits do
  use Ecto.Migration

  def change do
    create table(:time_units) do
      add :name, :string

      timestamps()
    end

  end
end
