defmodule Secrets.GrpcApi.Test do
  use ExUnit.Case

  alias Yapi.Secrets.{Secret, SecretService, ResponseMeta, RequestMeta, CreateRequest, GetRequest}
  alias Secrets.Store

  @req_meta Yapi.Secrets.RequestMeta.new(
    api_version: "v1alpha",
    kind: "Secret",
    req_id: "d593bbb0-59a0-4bc9-914c-8e4890768459",
    org_id: "eb668a68-78bf-434c-8978-83e293d9619e",
    user_id: "2a2bfb37-4c0d-41ca-aa5b-59a002a861c4")

  setup do
    Store.clear!

    :ok
  end

  describe ".get" do
    test "when the secret exists => it returns status ok" do
      create()

      req = GetRequest.new(metadata: @req_meta, name: "aws-secrets")

      {:ok, channel} = GRPC.Stub.connect("localhost:50051")
      {:ok, response} = SecretService.Stub.get(channel, req)

      assert response.secret.metadata.name == "aws-secrets"
    end

    test "when the secret doesn't exists => it returns status not_found" do
      req = GetRequest.new(metadata: @req_meta, name: "aws-secrets")

      {:ok, channel} = GRPC.Stub.connect("localhost:50051")
      {:ok, response} = SecretService.Stub.get(channel, req)

      assert response.metadata.status.code == ResponseMeta.Code.value(:NOT_FOUND)
    end
  end

  describe ".create" do
    test "saves the secret to the store" do
      create()

      {:ok, secret} = Store.get("aws-secrets")

      assert secret.metadata.name == "aws-secrets"
    end

    test "when saving succeds => it returns status OK" do
      response = create()

      assert response.metadata.status.code == ResponseMeta.Code.value(:OK)
    end

    test "when saving succeds => it returns the secret" do
      response = create()

      assert response.secret.metadata.name == "aws-secrets"
    end
  end

  def create do
    secret = Secret.new(
      metadata: Secret.Metadata.new(name: "aws-secrets"),
      data: [
        Secret.Entry.new(name: "aws-id", value: "21"),
        Secret.Entry.new(name: "aws-token", value: "42is2times21")
      ]
    )

    req = CreateRequest.new(metadata: @req_meta, secret: secret)

    {:ok, channel} = GRPC.Stub.connect("localhost:50051")
    {:ok, response} = SecretService.Stub.create(channel, req)

    response
  end
end
