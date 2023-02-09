defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "12345678901"
      user = build(:user, cpf: cpf)
      UserAgent.save(user)

      item_1 = build(:item)

      item_2 =
        build(:item,
          description: "Hamburger",
          category: :hamburger,
          quantity: 2,
          unity_price: Decimal.new("15.50")
        )

      {:ok, user_cpf: cpf, item_1: item_1, item_2: item_2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item_1: item_1,
      item_2: item_2
    } do
      order_params = %{
        user_cpf: cpf,
        items: [item_1, item_2]
      }

      response = CreateOrUpdate.call(order_params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, return an error", %{
      item_1: item_1,
      item_2: item_2
    } do
      order_params = %{
        user_cpf: "00000000000",
        items: [item_1, item_2]
      }

      response = CreateOrUpdate.call(order_params)

      expected_response = {:error, :user_not_found}

      assert expected_response == response
    end

    test "when there is no items, return an error", %{user_cpf: cpf} do
      order_params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(order_params)

      expected_response = {:error, :invalid_order}

      assert expected_response == response
    end

    test "when there are invalid items, return an error", %{
      user_cpf: cpf,
      item_1: item_1
    } do
      invalid_item = %{item_1 | quantity: 0}

      order_params = %{user_cpf: cpf, items: [invalid_item]}

      response = CreateOrUpdate.call(order_params)

      expected_response = {:error, :invalid_items}

      assert expected_response == response
    end
  end
end
