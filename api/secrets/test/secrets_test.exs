defmodule SecretsTest do
  use ExUnit.Case
  doctest Secrets

  test "greets the world" do
    assert Secrets.hello() == :world
  end
end
