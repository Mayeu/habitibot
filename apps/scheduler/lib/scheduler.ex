defmodule Scheduler do
  use Quantum.Scheduler, otp_app: :scheduler

  @moduledoc """
  Documentation for Scheduler.
  """

  @doc """

  """
  def schedule_quest_acceptation() do
    import Ecto.Query, only: [from: 2]

    opq_opt = Application.get_env(:scheduler, :opq)

    query = from(u in Repository.User, where: u.quest_bot == true)
    users = Repository.all(query)
    IO.inspect(users)
    Enum.each(users, fn user -> schedule_quest_acceptation(user, opq_opt) end)
  end

  defp schedule_quest_acceptation(user, opq) do
    conn = %Habitica.API.Connection{
      id: user.user_id,
      token: user.api_token,
      host: URI.parse("http://localhost:3000")
    }

    IO.inspect(conn)
    OPQ.enqueue(opq, Habitibot, :accept_quest, [conn])
  end
end
