defmodule Dragonhacks.SharedMap do
  use GenServer

  # Client
  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  def get(name, key, default) do
    GenServer.call(name, {:get, key, default})
  end

  def put(name, key, val) do
    GenServer.cast(name, {:put, key, val})
  end

  # Server
  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:get, key, default}, _, state) do
    {:reply, Map.get(state, key, default), state}
  end

  def handle_cast({:put, key, val}, state) do
    {:noreply, Map.put(state, key, val)}
  end
end
