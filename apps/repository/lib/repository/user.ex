defmodule Repository.User do
  use Ecto.Schema

  alias Ecto

  schema "users" do
    field(:user_id, :string)
    field(:api_token, :string)
    field(:username, :string)
    field(:group_id, :string)
    field(:quest_bot, :boolean, default: false)
  end

  def changeset(user, params \\ %{}) do
    accepted_fields = [:user_id, :api_token, :username, :group_id, :quest_bot]
    required_fields = [:user_id, :api_token, :username, :quest_bot]

    user
    |> Ecto.Changeset.cast(params, accepted_fields)
    |> Ecto.Changeset.validate_required(required_fields)
  end
end
