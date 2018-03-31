defmodule Repository.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:user_id, :string)
      add(:api_token, :string)
      add(:username, :string)
      add(:group_id, :string)
      add(:quest_bot, :boolean)
    end
  end
end
