defmodule SecretsApi do
  require Logger

  use GRPC.Server, service: Yapi.Secrets.Service

  def list(req, _) do
    Logger.info "Describing #{inspect(req)}"

    case Store.list(page: req.pagination.page, page_size: req.pagination.page_size) do
      {:ok, secrets, total_entries, total_pages} ->
        pagination = Yapi.Secrets.Pagination.new(
          page_number: req.pagination.page,
          page_size: Enum.count(secrets),
          total_entries: total_entries,
          total_pages: total_pages)

        Yapi.Secrets.ListRequest.new(status: status_ok(), secrets: secrets, pagination: pagination)
      {:error, message} ->
        Yapi.Secrets.CreateResponse.new(status: status_not_ok(), message: message)
    end
  end

  def describe(req, _) do
    Logger.info "Describing #{inspect(req)}"

    case Store.fetch(req.secret) do
      {:ok, _} ->
        Yapi.Secrets.CreateResponse.new(status: status_ok())
      {:error, message} ->
        Yapi.Secrets.CreateResponse.new(status: status_not_ok(), message: message)
    end
  end

  def create(req, _) do
    Logger.info "Creating #{inspect(req)}"

    case Store.create(req.secret) do
      {:ok, secret} ->
        Yapi.Secrets.CreateResponse.new(status: status_ok(), secret: secret)
      {:error, message} ->
        Yapi.Secrets.CreateResponse.new(status: status_not_ok(), message: message)
    end
  end

  def update(req, _) do
    Logger.info "Updating #{inspect(req)}"

    case Store.update(req.secret) do
      {:ok, secret} ->
        Yapi.Secrets.UpdateResponse.new(status: status_ok(), secret)
      {:error, message} ->
        Yapi.Secrets.UpdateResponse.new(status: status_not_ok(), message: message)
    end
  end

  def delete(req, _) do
    Logger.info "Deleting #{req.id}"

    case Store.delete(req.id) do
      {:ok, _} ->
        Yapi.Secrets.DeleteResponse.new(status: status_ok())
      {:error, message} ->
        Yapi.Secrets.DeleteResponse.new(status: status_not_ok(), message: message)
    end
  end

  def status_ok do
    Yapi.Secrets.Status.new(code: Yapi.Secrets.Status.Code.code(:OK))
  end

  def status_not_ok do
    Yapi.Secrets.Status.new(code: Yapi.Secrets.Status.Code.code(:OK))
  end

end
