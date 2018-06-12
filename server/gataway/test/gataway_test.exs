defmodule GatawayTest do
  use ExUnit.Case
  doctest Gataway

  test "greets the world" do
    assert Gataway.hello() == :world
  end
end
