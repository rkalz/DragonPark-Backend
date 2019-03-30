defmodule DragonhacksWeb.Router do
  use DragonhacksWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "*"]
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  scope "/api", DragonhacksWeb do
    pipe_through :api

    resources "/lots", LotController, except: [:new, :edit]
    resources "/reports", ReportController, except: [:new, :edit]
  end
end
