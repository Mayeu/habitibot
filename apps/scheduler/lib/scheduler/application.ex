defmodule Scheduler.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    {:ok, opq} = OPQ.init()
    Application.put_env(:scheduler, :opq, opq)

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Scheduler.Worker.start_link(arg)
      # {Scheduler.Worker, arg},
      Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scheduler.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
