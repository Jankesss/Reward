defmodule Rewarder.Reward_historyTest do
  use Rewarder.DataCase

  alias Rewarder.Reward_history

  describe "history" do
    alias Rewarder.Reward_history.Stories

    import Rewarder.Reward_historyFixtures

    @invalid_attrs %{description: nil, userid: nil}

    test "list_history/0 returns all history" do
      stories = stories_fixture()
      assert Reward_history.list_history() == [stories]
    end

    test "get_stories!/1 returns the stories with given id" do
      stories = stories_fixture()
      assert Reward_history.get_stories!(stories.id) == stories
    end

    test "create_stories/1 with valid data creates a stories" do
      valid_attrs = %{description: "some description", userid: 42}

      assert {:ok, %Stories{} = stories} = Reward_history.create_stories(valid_attrs)
      assert stories.description == "some description"
      assert stories.userid == 42
    end

    test "create_stories/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Reward_history.create_stories(@invalid_attrs)
    end
  end
end
