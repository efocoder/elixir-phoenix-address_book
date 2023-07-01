defmodule AddressBook.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AddressBookWeb.Telemetry,
      # Start the Ecto repository
      AddressBook.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AddressBook.PubSub},
      # Start Finch
      {Finch, name: AddressBook.Finch},
      # Start the Endpoint (http/https)
      AddressBookWeb.Endpoint
      # Start a worker by calling: AddressBook.Worker.start_link(arg)
      # {AddressBook.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AddressBook.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AddressBookWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
