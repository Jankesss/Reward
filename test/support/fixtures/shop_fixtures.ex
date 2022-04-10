defmodule Rewarder.ShopFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewarder.Shop` context.
  """

  @doc """
  Generate a reward.
  """
  def reward_fixture(attrs \\ %{}) do
    {:ok, reward} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        price: 42
      })
      |> Rewarder.Shop.create_reward()

    reward
  end
end
