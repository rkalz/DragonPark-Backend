defmodule Dragonhacks.Lots.Report do
  use Ecto.Schema
  import Ecto.Changeset

  alias Dragonhacks.Lots.Lot


  schema "reports" do
    field :status, :string
    field :timestamp, :utc_datetime
    belongs_to :lot, Lot

    timestamps()
  end

  @doc false
  def changeset(report, attrs) do
    report
    |> cast(attrs, [:status, :timestamp])
    |> validate_required([:status, :timestamp])
  end
end
