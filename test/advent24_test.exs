defmodule Advent24Test do
  use ExUnit.Case
  doctest Advent24

  def lines(s), do: String.split(s, "\n")

  test "Day 1" do
    input = "
3   4
4   3
2   5
1   3
3   9
3   3"
    assert Advent24.historian_hysteria(lines(input)) == 11
    assert Advent24.historian_hysteria_similarity(lines(input)) == 31
  end
end
