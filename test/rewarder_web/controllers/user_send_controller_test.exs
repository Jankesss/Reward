defmodule RewarderWeb.UserSendControllerTest do
  use RewarderWeb.ConnCase

  import Rewarder.AccountsFixtures
  setup :register_and_log_in_user

  @update_attrs %{points: 10, userid: 1}
  #@invalid_attrs %{points: nil, userid: nil}

  describe "show" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_send_path(conn, :show))
      assert html_response(conn, 200) =~ "Reward someone with your points"
    end
  end


end
