defmodule Habitica.Group do
  defstruct _id: nil,
            balance: nil,
            challengeCount: nil,
            chat: nil,
            id: nil,
            leader: nil,
            leaderOnly: nil,
            memberCount: nil,
            name: nil,
            privacy: nil,
            quest: nil,
            tasksOrder: nil,
            type: nil

  # @type t :: %Habitica.Group{
  #         _id: String.t(),
  #         balance: integer,
  #         challengeCount: integer,
  #         chat: [any],
  #         id: String.t(),
  #         leader: %{any},
  #         leaderOnly: %{any},
  #         memberCount: integer,
  #         name: String.t(),
  #         privacy: String.t(),
  #         quest: %{any},
  #         tasksOrder: %{any},
  #         type: String.t()
  # }
end
