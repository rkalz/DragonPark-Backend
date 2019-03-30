defmodule DragonhacksWeb.RoomChannel do
  use Phoenix.Channel

  import Ecto.Query

  def join("room:global", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> lot_id, _params, socket) do
    test_query = "lots" |> where([u], u.id == ^lot_id) |> select([u], u.id)
    result = Dragonhacks.Repo.one(test_query)

    if result == nil do
      {:error, %{reason: "invalid id"}}
    else
      {:ok, socket}
    end
  end
end
