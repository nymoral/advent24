defmodule Advent24Test do
  use ExUnit.Case
  doctest Advent24

  def lines(s), do: String.split(s, "\n")

  test "Day 2" do
    input = "
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"
    assert Advent24.red_nosed_reports(lines(input)) == 2
    assert Advent24.red_nosed_reports_damp(lines(input)) == 4
  end

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
