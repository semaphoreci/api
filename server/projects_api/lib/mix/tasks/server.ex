defmodule Mix.Tasks.Server.Start do
  require Logger

  @port 5000

  def run(_) do
    Application.ensure_all_started(:projects_api)

    Logger.info "Running server on localhost:#{@port} in #{Mix.env} environment."

    {:ok, _} = Plug.Adapters.Cowboy.http ProjectsApi, [], port: @port

    Process.sleep(:infinity)
  end

end
