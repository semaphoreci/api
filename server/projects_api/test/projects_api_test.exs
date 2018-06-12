defmodule ProjectsApiTest do
  use ExUnit.Case
  doctest ProjectsApi

  test "greets the world" do
    assert ProjectsApi.hello() == :world
  end
end
