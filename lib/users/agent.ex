defmodule Exlivery.Users.Agent do
  use Agent
  alias Exlivery.Users.User

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user), do: Agent.update(__MODULE__, &Map.put(&1, user.cpf, user))

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  defp get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end
end
