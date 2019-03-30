defmodule Dragonhacks.Repo.Migrations.CreateLots do
  use Ecto.Migration

  def change do
    create table(:lots) do
      add :name, :string
      add :address, :string
      add :lat, :float
      add :lng, :float
      add :status, :string

      timestamps()
    end

  end
end
