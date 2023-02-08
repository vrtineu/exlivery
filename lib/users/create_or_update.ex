defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.Agent, as: UsersAgent
  alias Exlivery.Users.User

  def call(%{name: name, address: address, email: email, cpf: cpf, age: age}) do
    address
    |> User.build(name, email, cpf, age)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}), do: UsersAgent.save(user)
  defp save_user({:error, _}), do: {:error, :invalid_params}
end
