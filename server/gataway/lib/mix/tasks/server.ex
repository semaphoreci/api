defmodule Mix.Tasks.Server.Start do
  require Logger

  @port 4000

  def run(_) do
    Application.ensure_all_started(:gataway)

    Logger.info "Running server on localhost:#{@port} in #{Mix.env} environment."

    {:ok, _} = Plug.Adapters.Cowboy.http Gataway, [], port: @port

    Process.sleep(:infinity)
  end

end
