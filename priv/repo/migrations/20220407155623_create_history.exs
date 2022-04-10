defmodule Rewarder.Repo.Migrations.CreateHistory do
  use Ecto.Migration

  def change do
    create table(:history) do
      add :userid, :integer
      add :description, :string

      timestamps()
    end
  end
end
