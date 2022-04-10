defmodule Rewarder.Reward_historyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rewarder.Reward_history` context.
  """

  @doc """
  Generate a stories.
  """
  def stories_fixture(attrs \\ %{}) do
    {:ok, stories} =
      attrs
      |> Enum.into(%{
        description: "some description",
        userid: 42
      })
      |> Rewarder.Reward_history.create_stories()

    stories
  end
end
