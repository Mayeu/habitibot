defmodule Repository.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_if_not_exists table(:users) do
      add(:user_id, :string)
      add(:api_token, :string)
      add(:username, :string)
      add(:group_id, :string)
      add(:quest_bot, :boolean)

      timestamps()
    end
  end
end
