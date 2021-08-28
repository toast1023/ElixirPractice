defmodule CryptobotTest do
  use ExUnit.Case
  doctest Cryptobot

  test "greets the world" do
    assert Cryptobot.hello() == :world
  end
end
