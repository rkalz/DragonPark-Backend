defmodule DragonhacksWeb.ReportController do
  use DragonhacksWeb, :controller

  alias Dragonhacks.Lots
  alias Dragonhacks.Lots.Report

  action_fallback DragonhacksWeb.FallbackController

  def index(conn, _params) do
    reports = Lots.list_reports()
    render(conn, "index.json", reports: reports)
  end

  def create(conn, %{"report" => report_params}) do
    transformed_params = Map.put(report_params, "timestamp", DateTime.utc_now() |> DateTime.to_string)
    with {:ok, %Report{} = report} <- Lots.create_report(transformed_params) do
      add_report_to_queue(report)

      conn
      |> put_status(:created)
      |> put_resp_header("location", report_path(conn, :show, report))
      |> render("show.json", report: report)
    end

    # TODO: Status for last hour
    # TODO: Emit to id channel
  end

  def add_report_to_queue(report) do
    lot_id = Map.get(report, "lot_id")
    timestamp = Map.get(report, "timestamp")
    queue = Dragonhacks.SharedMap.get(lot_id)
    queue = :queue.in(timestamp, queue)
    Dragonhacks.SharedMap.put(lot_id, queue)
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
