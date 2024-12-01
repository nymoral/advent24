defmodule Advent24 do
  @type input() :: Enumerable.t(String.t())

  ## Day 1
  @spec historian_hysteria(input()) :: integer
  def historian_hysteria(input) do
    clean_lines(input)
    |> hh_to_lists()
    |> Stream.map(&Enum.sort/1)
    |> Stream.zip()
    |> Stream.map(fn {a, b} -> Kernel.abs(a-b) end)
    |> Enum.sum()
  end

  @spec historian_hysteria_similarity(input()) :: integer
  def historian_hysteria_similarity(input) do
    [a, b] = clean_lines(input)
    |> hh_to_lists()
    {counted_a, counted_b} = {count(a), count(b)}
    counted_a
    |> Stream.map(fn {a, c} -> c * a * Map.get(counted_b, a, 0) end)
    |> Enum.sum()
  end

  @spec hh_to_lists(input()) :: [[integer]]
  def hh_to_lists(input) do
    input
    |> Stream.map(fn line ->
      [a, b] = String.split(line)
      {String.to_integer(a), String.to_integer(b)}
    end)
    |> Enum.reduce([[], []], fn {a, b}, [la, lb] -> [[a | la], [b | lb]] end)
  end


  ## Utilities

  @spec clean_lines(input()) :: input()
  defp clean_lines(input) do
    input
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(String.length(&1) > 0))
  end

  @spec count(Enumerable.t(any())) :: %{any() => integer}
  defp count(elements) do
    Enum.reduce(elements, %{}, fn e, acc ->
      Map.update(acc, e, 1, &(&1+1))
    end)
  end

end
