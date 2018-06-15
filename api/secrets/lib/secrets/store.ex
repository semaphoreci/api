defmodule Secrets.Store do
  require Logger

  def save(secret) do
    {:ok, _} = Cachex.put(:store, secret.metadata.name, secret)

    {:ok, secret}
  end

  def get(name) do
    case Cachex.get(:store, name) do
      {:ok, nil} -> {:error, :not_found}
      {:ok, val} -> {:ok, val}
      _ -> {:error, :unknown}
    end
  end

  def clear! do
    Cachex.clear!(:store)
  end

end
