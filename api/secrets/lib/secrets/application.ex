defmodule Secrets.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      %{id: Cachex, start: {Cachex, :start_link, [:store, []]}}
    ]

    opts = [strategy: :one_for_one, name: Secrets.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
