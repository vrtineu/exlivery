defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{
        name: "John Doe",
        email: "john@doe.com",
        cpf: "12345678901",
        age: 18,
        address: "Rua 1"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, :user_created}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "John Doe",
        email: "john@doe.com",
        cpf: "12345678901",
        age: 17,
        address: "Rua 1"
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, :invalid_params}

      assert response == expected_response
    end
  end
end
