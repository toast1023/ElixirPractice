defmodule KanyeQuotesTest do
  use ExUnit.Case
  doctest KanyeQuotes

  test "greets the world" do
    assert KanyeQuotes.hello() == :world
  end
end
