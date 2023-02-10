defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrdersAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrdersAgent.start_link(%{})

      :order
      |> build()
      |> OrdersAgent.save()

      :order
      |> build()
      |> OrdersAgent.save()

      expected_response =
        "12345678901,pizza,1,10.00hamburger,2,15.50,41.00\n" <>
          "12345678901,pizza,1,10.00hamburger,2,15.50,41.00\n"

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
