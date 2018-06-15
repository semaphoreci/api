defmodule Secrets.GrpcApi do
  require Logger

  alias Yapi.Secrets.{SecretService, ResponseMeta, CreateResponse, GetResponse}
  alias Secrets.Store

  use GRPC.Server, service: SecretService.Service

  def get(req, _) do
    Logger.info "Getting #{inspect(req)}"

    case Store.get(req.name) do
      {:ok, secret} ->
        GetResponse.new(metadata: status_ok(req), secret: secret)
      {:error, :not_found} ->
        GetResponse.new(metadata: status_not_ok(req, :NOT_FOUND))
    end
  end

  def create(req, _) do
    Logger.info "Creating #{inspect(req)}"

    case Store.save(req.secret) do
      {:ok, secret} ->
        CreateResponse.new(metadata: status_ok(req), secret: secret)
      {:error, message} ->
        CreateResponse.new(status: status_not_ok(req, :NOT_FOUND), message: message)
    end
  end

  defp status_ok(req) do
     ResponseMeta.new(
      api_version: req.metadata.api_version,
      kind: req.metadata.kind,
      req_id: req.metadata.req_id,
      org_id: req.metadata.org_id,
      user_id: req.metadata.user_id,
      status: ResponseMeta.Status.new(code: ResponseMeta.Code.value(:OK)))
  end

  defp status_not_ok(req, code) do
     ResponseMeta.new(
      api_version: req.metadata.api_version,
      kind: req.metadata.kind,
      req_id: req.metadata.req_id,
      org_id: req.metadata.org_id,
      user_id: req.metadata.user_id,
      status: ResponseMeta.Status.new(code: ResponseMeta.Code.value(code)))
  end

end
