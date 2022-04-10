defmodule Rewarder.Shop.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rewards" do
    field :description, :string
    field :name, :string
    field :price, :integer

    timestamps()
  end

  @doc false
  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [:name, :description, :price])
    |> validate_required([:name, :description, :price])
  end
end
