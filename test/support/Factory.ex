defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Rua 1",
      name: "John Doe",
      email: "john@doe.com",
      cpf: "12345678901",
      age: 18
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de calabresa",
      category: :pizza,
      unity_price: Decimal.new("10.00"),
      quantity: 1
    }
  end
end
