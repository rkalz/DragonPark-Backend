defmodule Dragonhacks.Lots do
  @moduledoc """
  The Lots context.
  """

  import Ecto.Query, warn: false
  alias Dragonhacks.Repo

  alias Dragonhacks.Lots.Lot

  @doc """
  Returns the list of lots.

  ## Examples

      iex> list_lots()
      [%Lot{}, ...]

  """
  def list_lots do
    Repo.all(Lot)
  end

  @doc """
  Gets a single lot.

  Raises `Ecto.NoResultsError` if the Lot does not exist.

  ## Examples

      iex> get_lot!(123)
      %Lot{}

      iex> get_lot!(456)
      ** (Ecto.NoResultsError)

  """
  def get_lot!(id), do: Repo.get!(Lot, id)

  @doc """
  Creates a lot.

  ## Examples

      iex> create_lot(%{field: value})
      {:ok, %Lot{}}

      iex> create_lot(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_lot(attrs \\ %{}) do
    %Lot{}
    |> Lot.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a lot.

  ## Examples

      iex> update_lot(lot, %{field: new_value})
      {:ok, %Lot{}}

      iex> update_lot(lot, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_lot(%Lot{} = lot, attrs) do
    lot
    |> Lot.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Lot.

  ## Examples

      iex> delete_lot(lot)
      {:ok, %Lot{}}

      iex> delete_lot(lot)
      {:error, %Ecto.Changeset{}}

  """
  def delete_lot(%Lot{} = lot) do
    Repo.delete(lot)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking lot changes.

  ## Examples

      iex> change_lot(lot)
      %Ecto.Changeset{source: %Lot{}}

  """
  def change_lot(%Lot{} = lot) do
    Lot.changeset(lot, %{})
  end

  alias Dragonhacks.Lots.Report

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Report{}, ...]

  """
  def list_reports do
    Repo.all(Report)
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_report!(id), do: Repo.get!(Report, id)

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{source: %Report{}}

  """
  def change_report(%Report{} = report) do
    Report.changeset(report, %{})
  end
end
