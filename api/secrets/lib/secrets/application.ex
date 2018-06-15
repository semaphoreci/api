defmodule Secrets.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    port = Application.get_env(:secrets, :http_port)

    children = [
      Plug.Adapters.Cowboy2.child_spec(scheme: :http, plug: Secrets.HttpApi, options: [port: port]),
      %{id: Cachex, start: {Cachex, :start_link, [:store, []]}}
    ]

    opts = [strategy: :one_for_one, name: Secrets.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
