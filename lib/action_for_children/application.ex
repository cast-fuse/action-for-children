defmodule ActionForChildren.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # loads environment vars for local development
    unless Mix.env == :prod do
      Envy.load([".env"])
      Envy.reload_config()
    end

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(ActionForChildren.Repo, []),
      # Start the endpoint when the application starts
      supervisor(ActionForChildren.Web.Endpoint, []),
      # Start your own worker by calling: ActionForChildren.Worker.start_link(arg1, arg2, arg3)
      # worker(ActionForChildren.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ActionForChildren.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
