defmodule ForesightTest do
  use ExUnit.Case
  doctest Foresight

  test "greets the world" do
    assert Foresight.hello() == :world
  end
end
