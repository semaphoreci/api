defmodule Secrets.HttpApi do
  alias Secrets.GrpcApi
  require Logger

  use Plug.Router

  @version "v1alpha"

  plug Plug.Logger, log: :debug
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  #
  # Health checks
  #

  get "/" do
    send_resp(conn, 200, "world")
  end

  get "/is_alive" do
    send_resp(conn, 200, "world")
  end

  #
  # Rest API
  #

  get "/api/#{@version}/secrets/:name" do
    req = Yapi.Secrets.GetRequest.new(metadata: construct_req_meta(conn), name: conn.params["name"])
    res = GrpcApi.get(req, nil)

    case Yapi.Secrets.ResponseMeta.Code.key(res.metadata.status.code) do
      :OK -> send_resp(conn, 200, Poison.encode!(res.secret))
      :NOT_FOUND -> send_resp(conn, 404, Poison.encode!(%{message: "Not found"}))
      _ -> send_resp(conn, 400, Poison.encode!(%{message: "Bad Request"}))
    end
  end

  post "/api/#{@version}/secrets" do
    req = Yapi.Secrets.CreateRequest.new(
      metadata: construct_req_meta(conn),
      secret: Yapi.Secrets.Secret.new(atomize(conn.body_params)))

    res = GrpcApi.create(req, nil)

    case Yapi.Secrets.ResponseMeta.Code.key(res.metadata.status.code) do
      :OK -> send_resp(conn, 200, Poison.encode!(res.secret))
      _ -> send_resp(conn, 400, Poison.encode!(%{message: "Bad Request"}))
    end
  end

  #
  # Fallback for unhandled paths
  #

  match _ do
    send_resp(conn, 404, "oops")
  end

  #
  # Utils
  #

  def construct_req_meta(conn) do
    req_id = hd(get_req_header(conn, "x-semaphore-req-id"))
    # org_id = hd(get_req_header(conn, "x-semaphore-org-id"))
    user_id = hd(get_req_header(conn, "x-semaphore-user-id"))
    org_id = "eb668a68-78bf-434c-8978-83e293d9619e"

    Yapi.Secrets.RequestMeta.new(
      api_version: @version,
      kind: "Secret",
      req_id: req_id,
      org_id: org_id,
      user_id: user_id)
  end

  #
  # This can't have good performance, but atm, this it the only way I know
  # how to make it work.
  #
  def atomize(map = %{}) do
    map
    |> Enum.map(fn {k, v} -> {String.to_atom(k), atomize(v)} end)
    |> Enum.into(%{})
  end

  def atomize(not_a_map) do
    not_a_map
  end

end
