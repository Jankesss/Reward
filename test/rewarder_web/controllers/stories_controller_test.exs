defmodule RewarderWeb.StoriesControllerTest do
  use RewarderWeb.ConnCase
  setup :register_and_log_in_user

  describe "index" do
    test "lists all history", %{conn: conn} do
      conn = get(conn, Routes.stories_path(conn, :admin_index))
      assert html_response(conn, 200) =~ "Listing history of claimed rewards"
    end
  end
end
