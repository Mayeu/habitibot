defmodule Habitibot.Application do
  @moduledoc """
  The Habitibot Application Service.

  The habitibot system business domain lives in this application.

  Exposes API to clients such as the `HabitibotWeb` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      
    ], strategy: :one_for_one, name: Habitibot.Supervisor)
  end
end
