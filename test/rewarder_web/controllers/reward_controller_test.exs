defmodule RewarderWeb.RewardControllerTest do
  use RewarderWeb.ConnCase

  import Rewarder.ShopFixtures

  @create_attrs %{description: "some description", name: "some name", price: 42}
  @update_attrs %{description: "some updated description", name: "some updated name", price: 43}
  @invalid_attrs %{description: nil, name: nil, price: nil}

  setup :register_and_log_in_user

  describe "index" do
    test "lists all rewards", %{conn: conn} do
      conn = get(conn, Routes.reward_path(conn, :index))
      assert html_response(conn, 200) =~ "Exchange points"
    end
  end

  describe "new reward" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.reward_path(conn, :new))
      assert html_response(conn, 200) =~ "New Reward"
    end
  end

  describe "create reward" do
    test "redirects to index when data is valid", %{conn: conn} do
      conn = post(conn, Routes.reward_path(conn, :create), reward: @create_attrs)

      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.reward_path(conn, :index))
      assert html_response(conn, 200) =~ "Exchange points"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.reward_path(conn, :create), reward: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Reward"
    end
  end

  describe "edit reward" do
    setup [:create_reward]

    test "renders form for editing chosen reward", %{conn: conn, reward: reward} do
      conn = get(conn, Routes.reward_path(conn, :edit, reward))
      assert html_response(conn, 200) =~ "Edit Reward"
    end
  end

  describe "update reward" do
    setup [:create_reward]

    test "redirects when data is valid", %{conn: conn, reward: reward} do
      conn = put(conn, Routes.reward_path(conn, :update, reward), reward: @update_attrs)
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.reward_path(conn, :index))
      assert html_response(conn, 200) =~ "Exchange points"
    end

    test "renders errors when data is invalid", %{conn: conn, reward: reward} do
      conn = put(conn, Routes.reward_path(conn, :update, reward), reward: @invalid_attrs)
      assert html_response(conn, 200) =~ "Exchange points"
    end
  end

  describe "delete reward" do
    setup [:create_reward]

    test "deletes chosen reward", %{conn: conn, reward: reward} do
      conn = delete(conn, Routes.reward_path(conn, :delete, reward))
      assert redirected_to(conn) == Routes.page_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.reward_path(conn, :index))
      end
    end
  end

  defp create_reward(_) do
    reward = reward_fixture()
    %{reward: reward}
  end
end
