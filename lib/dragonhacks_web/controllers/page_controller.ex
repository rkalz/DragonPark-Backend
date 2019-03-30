defmodule DragonhacksWeb.PageController do
  use DragonhacksWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
