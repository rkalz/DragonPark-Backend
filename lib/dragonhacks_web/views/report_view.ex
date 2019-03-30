defmodule DragonhacksWeb.ReportView do
  use DragonhacksWeb, :view
  alias DragonhacksWeb.ReportView

  def render("index.json", %{reports: reports}) do
    %{data: render_many(reports, ReportView, "report.json")}
  end

  def render("show.json", %{report: report}) do
    %{data: render_one(report, ReportView, "report.json")}
  end

  def render("report.json", %{report: report}) do
    %{id: report.id,
      status: report.status,
      timestamp: report.timestamp}
  end

  def render("report_no_id.json", %{report: report}) do
    %{status: Map.get(report, "status"),
      timestamp: Map.get(report, "timestamp") |> report_timestamp_to_string}
  end

  defp report_timestamp_to_string( { {year, month, day}, {hour, minute, seconds, microseconds} }) do
    "#{year}-#{month}-#{day}T#{hour}:#{minute}:#{seconds}.#{microseconds}Z"
  end

  defp report_timestamp_to_string( %DateTime{} = time ) do
    time |> DateTime.to_string
  end
end
