defmodule RewarderWeb.UserSendController do
  use RewarderWeb, :controller

  alias Rewarder.Accounts
  import Kernel

  def show(conn, _params) do
    users = Accounts.list_users()
    render(conn, "show.html", users: users)
  end

  def send(conn, %{"pointsTS" => %{"pointsTS" => amount_sent, "userid" => userid}}) do
    Accounts.send_points(conn, amount_sent, userid)
    conn
    |> put_flash(:info, "Points successfully granted!")
    |> redirect(to: Routes.user_send_path(conn, :show))
  end

  def give_pointsTS(conn, _params) do
    Accounts.grant_points_to_users()
    conn
    |> put_flash(:info, "Points has been given to the users.")
    |> redirect(to: Routes.user_send_path(conn, :show))
  end
end
