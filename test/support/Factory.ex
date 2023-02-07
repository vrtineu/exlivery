defmodule Exlivery.Factory do
  use ExMachina

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
end
