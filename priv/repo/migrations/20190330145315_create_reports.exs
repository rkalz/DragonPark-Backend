defmodule Dragonhacks.Repo.Migrations.CreateReports do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :status, :string
      add :timestamp, :utc_datetime
      add :lot_id, references(:lots, column: :id, on_delete: :nothing)

      timestamps()
    end

    create index(:reports, [:lot_id])
  end
end
