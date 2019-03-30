defmodule DragonhacksWeb.LotControllerTest do
  use DragonhacksWeb.ConnCase

  alias Dragonhacks.Lots
  alias Dragonhacks.Lots.Lot

  @create_attrs %{address: "some address", lat: 120.5, lng: 120.5, name: "some name", status: "some status"}
  @update_attrs %{address: "some updated address", lat: 456.7, lng: 456.7, name: "some updated name", status: "some updated status"}
  @invalid_attrs %{address: nil, lat: nil, lng: nil, name: nil, status: nil}

  def fixture(:lot) do
    {:ok, lot} = Lots.create_lot(@create_attrs)
    lot
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all lots", %{conn: conn} do
      conn = get conn, lot_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create lot" do
    test "renders lot when data is valid", %{conn: conn} do
      conn = post conn, lot_path(conn, :create), lot: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, lot_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "address" => "some address",
        "lat" => 120.5,
        "lng" => 120.5,
        "name" => "some name",
        "status" => "some status"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, lot_path(conn, :create), lot: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update lot" do
    setup [:create_lot]

    test "renders lot when data is valid", %{conn: conn, lot: %Lot{id: id} = lot} do
      conn = put conn, lot_path(conn, :update, lot), lot: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, lot_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "address" => "some updated address",
        "lat" => 456.7,
        "lng" => 456.7,
        "name" => "some updated name",
        "status" => "some updated status"}
    end

    test "renders errors when data is invalid", %{conn: conn, lot: lot} do
      conn = put conn, lot_path(conn, :update, lot), lot: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete lot" do
    setup [:create_lot]

    test "deletes chosen lot", %{conn: conn, lot: lot} do
      conn = delete conn, lot_path(conn, :delete, lot)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, lot_path(conn, :show, lot)
      end
    end
  end

  defp create_lot(_) do
    lot = fixture(:lot)
    {:ok, lot: lot}
  end
end
