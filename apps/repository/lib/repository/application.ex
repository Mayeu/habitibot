defmodule Repository.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Repository.Worker.start_link(arg)
      # {Repository.Worker, arg},
      supervisor(Repository, [])
    ]

    IO.inspect(Application.get_env(:ecto_mnesia, :host))
    IO.inspect(Application.get_env(:ecto_mnesia, :storage_type))

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Repository.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
