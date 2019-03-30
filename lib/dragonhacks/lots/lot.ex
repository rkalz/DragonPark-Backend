defmodule Dragonhacks.Lots.Lot do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lots" do
    field :address, :string
    field :lat, :float
    field :lng, :float
    field :name, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(lot, attrs) do
    lot
    |> cast(attrs, [:name, :address, :lat, :lng, :status])
    |> validate_required([:name, :address, :lat, :lng, :status])
  end
end
