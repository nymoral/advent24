input = "2.txt"
solution = &Advent24.red_nosed_reports_damp/1


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
