defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response = User.build("Rua 1", "John Doe", "john@doe.com", "12345678901", 18)

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when age is less than 18, returns an error" do
      response = User.build("Rua 1", "John Doe", "john@doe.com", "12345678901", 17)

      expected_response = {:error, :invalid_user}

      assert response == expected_response
    end
  end
end
