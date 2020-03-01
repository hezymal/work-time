defmodule WorktimeServer.Repo.Migrations.CreateTimeUnitTransitions do
  use Ecto.Migration

  def change do
    create table(:time_unit_transitions) do
      add :time_unit_id, :integer
      add :kind, :string

      timestamps()
    end

  end
end
