defmodule Rewarder.Reward_history.Stories do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias Rewarder.Reward_history
  schema "history" do
    field :description, :string
    field :userid, :integer

    timestamps()
  end

  @doc false
  def changeset(stories, attrs) do
    stories
    |> cast(attrs, [:userid, :description])
    |> validate_required([:userid, :description])
  end

  def query_by_month(query, date_month) do
    query = from(q in query, where: fragment("date_part('month', ?)", q.inserted_at) == ^date_month)
    Reward_history.get_sorted_stories!(query)
  end

  def query_by_id(query, userid) do
    query = from(q in query, where: q.id == ^userid)
    Reward_history.get_sorted_stories!(query)
  end
end
