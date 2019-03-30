defmodule Dragonhacks.SharedMap do
  use GenServer

  require Logger

  # Client
  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def put(key, val) do
    GenServer.cast(__MODULE__, {:put, key, val})
  end

  # Server
  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key, :queue.new), state}
  end

  def handle_cast({:put, key, val}, state) do
    {:noreply, Map.put(state, key, val)}
  end
end
