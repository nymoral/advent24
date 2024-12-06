defmodule Advent24 do
  @type input() :: Enumerable.t(String.t())

  ## Day 2

  @spec red_nosed_reports_damp(input()) :: integer
  def red_nosed_reports_damp(input) do
    table(input)
    |> Stream.filter(fn report -> rnr_safe(report, 1) end)
    |> Enum.count()
  end

  @doc """
    iex> Advent24.rnr_safe([7, 6, 4, 2, 1])
    true
    iex> Advent24.rnr_safe([1, 3, 2, 4, 5])
    true
    iex> Advent24.rnr_safe([1, 2, 7, 8, 9])
    false
    iex> Advent24.rnr_safe(Enum.reverse([7, 6, 4, 2, 1]))
    true
    iex> Advent24.rnr_safe(Enum.reverse([1, 3, 2, 4, 5]))
    true
    iex> Advent24.rnr_safe(Enum.reverse([1, 2, 7, 8, 9]))
    false
  """
  def rnr_safe(report, allowed_removals\\1) do
    rnr_safe(report, allowed_removals, 1)
      or rnr_safe(report, allowed_removals, -1)
  end

  def rnr_safe(report, allowed_removals, order, prefix\\[])
  # If removals go negative, it means that too many items need removing
  def rnr_safe(_, removals, _, _) when removals < 0, do: false
  # If one item is left it means we have safe sequence
  def rnr_safe([a, b | rest], removals, order, prefix) do
    #IO.inspect({[a, b | rest], removals, order}, charlists: :as_lists)
    if rnr_good(a, b, order) do
      rnr_safe([b | rest], removals, order, [a])
    else
      case prefix do
        [] -> 
          rnr_safe([b | rest], removals-1, order, [])
        [p] -> 
          if rnr_good(p, b, order) do
            rnr_safe([b | rest], removals-1, order, [p])
          else
            false
          end
        end
      end
    end

  def rnr_good(a, b, order) do
    ordered_diff = (b-a)*order
    ordered_diff >= 1 and ordered_diff <= 3
  end

  @spec red_nosed_reports(input()) :: integer
  def red_nosed_reports(input) do
    table(input)
    |> Stream.filter(fn report -> rnr_safe(report, 0) end)
    |> Enum.count()
  end

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

  @spec table(input()) :: [[integer]]
  defp table(input) do
    clean_lines(input)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
  end

  @spec count(Enumerable.t(any())) :: %{any() => integer}
  defp count(elements) do
    Enum.reduce(elements, %{}, fn e, acc ->
      Map.update(acc, e, 1, &(&1+1))
    end)
  end

end
