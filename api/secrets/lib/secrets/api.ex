defmodule Secrets.Api do
  require Logger

  use GRPC.Server, service: Yapi.Secrets.Service

  def describe(req, _) do
    Logger.info "Describing #{inspect(req)}"

    case decode(Store.get(req.id)) do
      {:ok, _} ->
        Yapi.Secrets.CreateResponse.new(status: status_ok())
      {:error, message} ->
        Yapi.Secrets.CreateResponse.new(status: status_not_ok(), message: message)
    end
  end

  def create(req, _) do
    Logger.info "Creating #{inspect(req)}"

    case Store.create(decode(req.secret)) do
      {:ok, secret} ->
        Yapi.Secrets.CreateResponse.new(status: status_ok(), secret: secret)
      {:error, message} ->
        Yapi.Secrets.CreateResponse.new(status: status_not_ok(), message: message)
    end
  end

end
