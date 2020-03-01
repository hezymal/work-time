defmodule WorktimeServer.TimeUnit do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, except: [:__meta__]}
  schema "time_units" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(time_unit, attrs) do
    time_unit
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
