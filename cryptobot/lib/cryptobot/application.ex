defmodule Cryptobot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Alchemy.Client

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Cryptobot.Worker.start_link(arg)
      # {Cryptobot.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Cryptobot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
