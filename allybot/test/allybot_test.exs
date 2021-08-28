defmodule AllybotTest do
  use ExUnit.Case
  doctest Allybot

  test "greets the world" do
    assert Allybot.hello() == :world
  end
end
