defmodule DragonhacksWeb.LotView do
  use DragonhacksWeb, :view
  alias DragonhacksWeb.LotView

  def render("index.json", %{lots: lots}) do
    %{data: render_many(lots, LotView, "lot.json")}
  end

  def render("show.json", %{lot: lot}) do
    %{data: render_one(lot, LotView, "lot.json")}
  end

  def render("lot.json", %{lot: lot}) do
    %{id: lot.id,
      name: lot.name,
      address: lot.address,
      lat: lot.lat,
      lng: lot.lng,
      status: lot.status
    }
  end

  def render("lot_and_reports.json", %{lot: lot, reports: reports}) do
    %{id: lot.id,
      name: lot.name,
      address: lot.address,
      lat: lot.lat,
      lng: lot.lng,
      status: lot.status,
      reports: render_many(reports, DragonhacksWeb.ReportView, "report_no_id.json")
    }
  end
end
