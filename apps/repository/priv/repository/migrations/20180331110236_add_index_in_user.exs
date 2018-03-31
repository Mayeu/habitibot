defmodule Repository.Migrations.AddIndexInUser do
  use Ecto.Migration

  def change do
    create(index(:users, [:user_id, :quest_bot]))
  end
end
