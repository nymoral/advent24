input = "1.txt"
solution = &Advent24.historian_hysteria_similarity/1


input_file = "inputs/#{input}"

{t, _} = :timer.tc(fn ->
  File.stream!(input_file)
  |> solution.()
  |> IO.puts()
end)

if t < 1000 do
  IO.puts("#{t}μs")
else
  IO.puts("#{div(t, 1000)}ms")
end
