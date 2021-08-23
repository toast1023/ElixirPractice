defmodule MixtestTest do
  use ExUnit.Case
  doctest Mixtest

  test "italicizes" do
    str = "Something *important*"
    assert Mixtest.test(str) =~ "<em>important</em>"
  end
end
