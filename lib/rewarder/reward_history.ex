defmodule Rewarder.Reward_history do
  @moduledoc """
  The Reward_history context.
  """

  import Ecto.Query, warn: false
  alias Rewarder.Repo

  alias Rewarder.Reward_history.Stories

  @doc """
  Returns the list of history.

  ## Examples

      iex> list_history()
      [%Stories{}, ...]

  """
  def list_history do
    Repo.all(Stories)
  end

  @doc """
  Gets a single stories.

  Raises `Ecto.NoResultsError` if the Stories does not exist.

  ## Examples

      iex> get_stories!(123)
      %Stories{}

      iex> get_stories!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stories!(id), do: Repo.get!(Stories, id)


  @doc """
  Gets a list of stories based on given query
  """
  def get_sorted_stories!(query), do: Repo.all(query)

  @doc """
  Creates a stories.

  ## Examples

      iex> create_stories(%{field: value})
      {:ok, %Stories{}}

      iex> create_stories(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stories(attrs \\ %{}) do
    %Stories{}
    |> Stories.changeset(attrs)
    |> Repo.insert()
  end





end
