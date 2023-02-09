defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      UserAgent.start_link(%{})

      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when the user is found, returns the user" do
      :user
      |> build(cpf: "12345678901")
      |> UserAgent.save()

      response = UserAgent.get("12345678901")

      expected_response =
        {:ok,
         %User{
           address: "Rua 1",
           name: "John Doe",
           email: "john@doe.com",
           cpf: "12345678901",
           age: 18
         }}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("12345678901")

      expected_response = {:error, :user_not_found}

      assert response == expected_response
    end
  end
end
