defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe "build/2" do
    test "when all params are valid, returns an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Hamburger",
          category: :hamburger,
          quantity: 2,
          unity_price: Decimal.new("15.50")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "when there is no items in the order, returns an error" do
      user = build(:user)

      response = Order.build(user, [])

      expected_response = {:error, :invalid_order}

      assert response == expected_response
    end
  end
end
