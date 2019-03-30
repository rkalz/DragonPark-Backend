defmodule Dragonhacks.LotsTest do
  use Dragonhacks.DataCase

  alias Dragonhacks.Lots

  describe "lots" do
    alias Dragonhacks.Lots.Lot

    @valid_attrs %{address: "some address", lat: 120.5, lng: 120.5, name: "some name", status: "some status"}
    @update_attrs %{address: "some updated address", lat: 456.7, lng: 456.7, name: "some updated name", status: "some updated status"}
    @invalid_attrs %{address: nil, lat: nil, lng: nil, name: nil, status: nil}

    def lot_fixture(attrs \\ %{}) do
      {:ok, lot} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lots.create_lot()

      lot
    end

    test "list_lots/0 returns all lots" do
      lot = lot_fixture()
      assert Lots.list_lots() == [lot]
    end

    test "get_lot!/1 returns the lot with given id" do
      lot = lot_fixture()
      assert Lots.get_lot!(lot.id) == lot
    end

    test "create_lot/1 with valid data creates a lot" do
      assert {:ok, %Lot{} = lot} = Lots.create_lot(@valid_attrs)
      assert lot.address == "some address"
      assert lot.lat == 120.5
      assert lot.lng == 120.5
      assert lot.name == "some name"
      assert lot.status == "some status"
    end

    test "create_lot/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lots.create_lot(@invalid_attrs)
    end

    test "update_lot/2 with valid data updates the lot" do
      lot = lot_fixture()
      assert {:ok, lot} = Lots.update_lot(lot, @update_attrs)
      assert %Lot{} = lot
      assert lot.address == "some updated address"
      assert lot.lat == 456.7
      assert lot.lng == 456.7
      assert lot.name == "some updated name"
      assert lot.status == "some updated status"
    end

    test "update_lot/2 with invalid data returns error changeset" do
      lot = lot_fixture()
      assert {:error, %Ecto.Changeset{}} = Lots.update_lot(lot, @invalid_attrs)
      assert lot == Lots.get_lot!(lot.id)
    end

    test "delete_lot/1 deletes the lot" do
      lot = lot_fixture()
      assert {:ok, %Lot{}} = Lots.delete_lot(lot)
      assert_raise Ecto.NoResultsError, fn -> Lots.get_lot!(lot.id) end
    end

    test "change_lot/1 returns a lot changeset" do
      lot = lot_fixture()
      assert %Ecto.Changeset{} = Lots.change_lot(lot)
    end
  end

  describe "reports" do
    alias Dragonhacks.Lots.Report

    @valid_attrs %{status: "some status", timestamp: "2010-04-17 14:00:00.000000Z"}
    @update_attrs %{status: "some updated status", timestamp: "2011-05-18 15:01:01.000000Z"}
    @invalid_attrs %{status: nil, timestamp: nil}

    def report_fixture(attrs \\ %{}) do
      {:ok, report} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lots.create_report()

      report
    end

    test "list_reports/0 returns all reports" do
      report = report_fixture()
      assert Lots.list_reports() == [report]
    end

    test "get_report!/1 returns the report with given id" do
      report = report_fixture()
      assert Lots.get_report!(report.id) == report
    end

    test "create_report/1 with valid data creates a report" do
      assert {:ok, %Report{} = report} = Lots.create_report(@valid_attrs)
      assert report.status == "some status"
      assert report.timestamp == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
    end

    test "create_report/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lots.create_report(@invalid_attrs)
    end

    test "update_report/2 with valid data updates the report" do
      report = report_fixture()
      assert {:ok, report} = Lots.update_report(report, @update_attrs)
      assert %Report{} = report
      assert report.status == "some updated status"
      assert report.timestamp == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
    end

    test "update_report/2 with invalid data returns error changeset" do
      report = report_fixture()
      assert {:error, %Ecto.Changeset{}} = Lots.update_report(report, @invalid_attrs)
      assert report == Lots.get_report!(report.id)
    end

    test "delete_report/1 deletes the report" do
      report = report_fixture()
      assert {:ok, %Report{}} = Lots.delete_report(report)
      assert_raise Ecto.NoResultsError, fn -> Lots.get_report!(report.id) end
    end

    test "change_report/1 returns a report changeset" do
      report = report_fixture()
      assert %Ecto.Changeset{} = Lots.change_report(report)
    end
  end
end
