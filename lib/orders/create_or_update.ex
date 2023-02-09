defmodule Exlivery.Orders.CreateOrUpdate do
  alias Exlivery.Orders.Agent, as: OrdersAgent
  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order
  alias Exlivery.Users.Agent, as: UserAgent

  def call(%{user_cpf: user_cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(user_cpf),
         {:ok, items} <- build_items(items),
         {:ok, order} <- Order.build(user, items) do
      OrdersAgent.save(order)
    end
  end

  defp build_items(items) do
    items
    |> Enum.map(&build_item/1)
    |> handle_build_items()
  end

  defp build_item(%{
         description: description,
         category: category,
         unity_price: unity_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unity_price, quantity) do
      {:ok, item} -> item
      {:error, _} = error -> error
    end
  end

  defp handle_build_items(items) do
    if Enum.all?(items, &is_struct/1) do
      {:ok, items}
    else
      {:error, :invalid_items}
    end
  end
end
