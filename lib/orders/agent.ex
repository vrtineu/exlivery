defmodule Exlivery.Orders.Agent do
  use Agent
  alias Exlivery.Orders.Order

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, uuid, order))
    {:ok, uuid}
  end

  defp update_state(state, uuid, order) do
    Map.put(state, uuid, order)
  end

  def get(uuid), do: Agent.get(__MODULE__, &get_order(&1, uuid))

  defp get_order(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, :not_found}
      order -> {:ok, order}
    end
  end
end
