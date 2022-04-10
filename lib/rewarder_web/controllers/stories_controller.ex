defmodule RewarderWeb.StoriesController do
  use RewarderWeb, :controller
  alias Rewarder.Reward_history

  def admin_index(conn, _params) do
    history = Reward_history.list_history()
    render(conn, "index.html", history: history)
  end

  def user_index(conn, _params) do
    history = Reward_history.Stories.query_by_id(Rewarder.Reward_history.Stories, conn.assigns.current_user.id)
    render(conn, "index.html", history: history)
  end

  def show_filtered_stories(conn,%{"month" => %{"month" => month}} = _params) do
    history = Reward_history.Stories.query_by_month(Rewarder.Reward_history.Stories, elem(Integer.parse(month), 0))
    render(conn, "index.html", history: history)
  end

end
