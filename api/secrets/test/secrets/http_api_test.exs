defmodule Secrets.HttpApi.Test do
  use ExUnit.Case

  @port Application.fetch_env!(:secrets, :http_port)
  @version "v1alpha"

  @headers [
    "content-type": "application/json",
    # "x-semaphore-org-id": "eb668a68-78bf-434c-8978-83e293d9619e", # TODO
    "x-semaphore-user-id": "eb668a68-78bf-434c-8978-83e293d9619e",
    "x-semaphore-req-id": "d593bbb0-59a0-4bc9-914c-8e4890768459",
  ]

  setup do
    Secrets.Store.clear!

    :ok
  end

  describe "GET /api/<version>/secrets/:name" do
    test "when secret is present => returns 200" do
      create()

      {:ok, response} = HTTPoison.get("http://localhost:#{@port}/api/#{@version}/secrets/aws-secrets", @headers)

      assert response.status_code == 200
    end

    test "when secret is not present => returns 404" do
      {:ok, response} = HTTPoison.get("http://localhost:#{@port}/api/#{@version}/secrets/aws-secrets", @headers)

      assert response.status_code == 404
    end

    test "when secret is present => it returns JSON encoded secret" do
      create()

      {:ok, response} = HTTPoison.get("http://localhost:#{@port}/api/#{@version}/secrets/aws-secrets", @headers)

      assert Poison.decode!(response.body) == %{
				"metadata" => %{"id" => "", "name" => "aws-secrets"},
				"data" => [
					%{"name" => "aws-id", "value" => "21"},
					%{"name" => "aws-token", "value" => "42is2times21"}
				]
			}
    end
  end

  describe "POST /api/<version>/secrets" do
    test "when secret creation succeds => returns 200" do
      resource = Poison.encode!(%{
				"metadata" => %{"name" => "aws-secrets"},
				"data" => [
					%{"name" => "aws-id", "value" => "21"},
					%{"name" => "aws-token", "value" => "42is2times21"}
				]
			})

      {:ok, response} = HTTPoison.post("http://localhost:#{@port}/api/#{@version}/secrets", resource, @headers)

      assert response.status_code == 200
      assert Poison.decode!(response.body) == %{
        "metadata" => %{"name" => "aws-secrets"},
        "data" => [
          %{"name" => "aws-id", "value" => "21"},
          %{"name" => "aws-token", "value" => "42is2times21"}
        ]
      }
    end
  end

  def create do
    alias Yapi.Secrets.Secret

    secret = Secret.new(
      metadata: Secret.Metadata.new(name: "aws-secrets"),
      data: [
        Secret.Entry.new(name: "aws-id", value: "21"),
        Secret.Entry.new(name: "aws-token", value: "42is2times21")
      ]
    )

    Secrets.Store.save(secret)
  end

end
