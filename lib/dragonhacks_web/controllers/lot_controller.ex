defmodule DragonhacksWeb.LotController do
  use DragonhacksWeb, :controller

  require Logger

  alias Dragonhacks.Lots
  alias Dragonhacks.Lots.Lot

  action_fallback DragonhacksWeb.FallbackController

  def index(conn, _params) do
    lots = Lots.list_lots()
    render(conn, "index.json", lots: lots)
  end

  def create(conn, %{"lot" => lot_params}) do
    with {:ok, %Lot{} = lot} <- Lots.create_lot(lot_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", lot_path(conn, :show, lot))
      |> render("show.json", lot: lot)
    end
  end

  def show(conn, %{"id" => id}) do
    lot = Lots.get_lot!(id)
    {lot_num, _} = Integer.parse(id)
    lot_queue = Dragonhacks.SharedMap.get(QueueMap, lot_num, :queue.new)
    report_list = :queue.to_list(lot_queue)

    lot_and_reports = %{
      lot: lot,
      reports: report_list
    }

    render(conn, "lot_and_reports.json", lot_and_reports)
  end

  def update(conn, %{"id" => id, "lot" => lot_params}) do
    lot = Lots.get_lot!(id)

    with {:ok, %Lot{} = lot} <- Lots.update_lot(lot, lot_params) do
      render(conn, "show.json", lot: lot)
    end
  end

  def delete(conn, %{"id" => id}) do
    lot = Lots.get_lot!(id)
    with {:ok, %Lot{}} <- Lots.delete_lot(lot) do
      send_resp(conn, :no_content, "")
    end
  end
end
