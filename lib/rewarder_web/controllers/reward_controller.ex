defmodule RewarderWeb.RewardController do
  use RewarderWeb, :controller

  alias Rewarder.Shop
  alias Rewarder.Shop.Reward


  def index(conn, _params) do
    rewards = Shop.list_rewards()
    render(conn, "index.html", rewards: rewards)
  end

  def new(conn, _params) do
    changeset = Shop.change_reward(%Reward{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"reward" => reward_params}) do
    case Shop.create_reward(reward_params) do
      {:ok, _reward} ->
        conn
        |> put_flash(:info, "Reward created successfully.")
        |> redirect(to: Routes.reward_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    reward = Shop.get_reward!(id)
    changeset = Shop.change_reward(reward)
    render(conn, "edit.html", reward: reward, changeset: changeset)
  end

  def update(conn, %{"id" => id, "reward" => reward_params}) do
    reward = Shop.get_reward!(id)

    case Shop.update_reward(reward, reward_params) do
      {:ok, _reward} ->
        conn
        |> put_flash(:info, "Reward updated successfully.")
        |> redirect(to: Routes.reward_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", reward: reward, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    reward = Shop.get_reward!(id)
    {:ok, _reward} = Shop.delete_reward(reward)

    conn
    |> put_flash(:info, "Reward deleted successfully.")
    |> redirect(to: Routes.reward_path(conn, :index))
  end

  def buy(conn, %{"reward_id" => id}) do
    if Shop.get_reward!(id).price < conn.assigns.current_user.pointsTE do
      case Shop.claim_prize(conn, id) do
        {:ok, _rewardprice} ->
          conn
            |> put_flash(:info, "Reward has been claimed. Check your e-mail for further informations")
            |> redirect(to: Routes.reward_path(conn, :index))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "index.html", id: id, changeset: changeset)
      end
    else
      conn
      |> put_flash(:error, "You don't have enough points to buy that")
      |> redirect(to: Routes.reward_path(conn, :index))
      |> halt()
    end
  end
end
