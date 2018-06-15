defmodule Secrets.Store do
  require Logger

  def save(secret) do
    Cachex.put!(:store, secret.metadata.name, secret)

    {:ok, secret}
  end

  def get(name) do
    Cachex.get!(:store, name)
  end

  def clear! do
    Cachex.clear!(:store)
  end

end
