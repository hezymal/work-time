defmodule WorktimeServer.TimeUnitTransition do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "time_unit_transitions" do
    field :kind, :string
    field :time_unit_id, :integer

    timestamps()
  end

  @doc false
  def changeset(time_unit_transition, attrs) do
    time_unit_transition
    |> cast(attrs, [:time_unit_id, :kind])
    |> validate_required([:time_unit_id, :kind])
  end
end
