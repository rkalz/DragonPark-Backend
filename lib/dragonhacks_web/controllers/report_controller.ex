defmodule DragonhacksWeb.ReportController do
  use DragonhacksWeb, :controller

  alias Dragonhacks.Lots
  alias Dragonhacks.Lots.Report

  require Logger

  action_fallback DragonhacksWeb.FallbackController

  def index(conn, _params) do
    reports = Lots.list_reports()
    render(conn, "index.json", reports: reports)
  end

  def create(conn, %{"report" => report_params}) do
    transformed_params = Map.put(report_params, "timestamp", DateTime.utc_now() |> DateTime.to_iso8601)
    add_report_to_queue(transformed_params)

    lot_id = Map.get(transformed_params, "lot_id")
    lot_queue = Dragonhacks.SharedMap.get(QueueMap, lot_id, nil)
    update_lot_status(lot_id, lot_queue, 0, 0)

    with {:ok, %Report{} = report} <- Lots.create_report(transformed_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", report_path(conn, :show, report))
      |> render("show.json", report: report)
    end
  end

  def add_report_to_queue(report) do
    lot_id = Map.get(report, "lot_id")
    queue = Dragonhacks.SharedMap.get(QueueMap, lot_id, :queue.new)

    {_, timestamp, _} = Map.get(report, "timestamp") |> DateTime.from_iso8601
    report = Map.put(report, "timestamp", timestamp)
    queue = :queue.in(report, queue)
    Dragonhacks.SharedMap.put(QueueMap, lot_id, queue)
  end

  def update_lot_status(lot_id, lot_queue, sum_of_status, consumed_reports) do
    if :queue.is_empty(lot_queue) do
      new_status = :math.floor(sum_of_status / consumed_reports)
      old_status = Dragonhacks.SharedMap.get(StatusMap, lot_id, 0)

      if new_status != old_status do
        Logger.debug "Lot status updated!"
        Dragonhacks.SharedMap.put(StatusMap, lot_id, new_status)
      end
    else
      oldest = :queue.get(lot_queue)
      oldest_time = Map.get(oldest, "timestamp")

      newest_time = Map.get(:queue.get_r(lot_queue), "timestamp")
      updated_queue = :queue.drop(lot_queue)

      if DateTime.diff(newest_time, oldest_time) > 3600 do
        update_lot_status(lot_id, updated_queue, sum_of_status, consumed_reports)
      else
        status = Map.get(oldest, "status")
        update_lot_status(lot_id, updated_queue, sum_of_status + status, consumed_reports + 1)
      end
    end
  end

  def show(conn, %{"id" => id}) do
    report = Lots.get_report!(id)
    render(conn, "show.json", report: report)
  end

  def update(conn, %{"id" => id, "report" => report_params}) do
    report = Lots.get_report!(id)

    with {:ok, %Report{} = report} <- Lots.update_report(report, report_params) do
      render(conn, "show.json", report: report)
    end
  end

  def delete(conn, %{"id" => id}) do
    report = Lots.get_report!(id)
    with {:ok, %Report{}} <- Lots.delete_report(report) do
      send_resp(conn, :no_content, "")
    end
  end
end
