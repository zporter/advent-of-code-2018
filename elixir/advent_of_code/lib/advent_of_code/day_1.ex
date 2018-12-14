defmodule AdventOfCode.Day1 do
  @spec calc_frequencies([binary]) :: integer
  def calc_frequencies([]), do: 0

  def calc_frequencies([frequency | frequencies]) do
    parse_frequency(frequency) + calc_frequencies(frequencies)
  end

  @spec duplicate_frequency([binary]) :: integer
  def duplicate_frequency(frequency_changes) do
    frequency_changes
    |> Stream.cycle()
    |> Enum.reduce_while({0, MapSet.new([0])}, fn freq_change, {current_freq, frequencies} ->
      freq = current_freq + parse_frequency(freq_change)

      if MapSet.member?(frequencies, freq) do
        {:halt, freq}
      else
        {:cont, {freq, MapSet.put(frequencies, freq)}}
      end
    end)
  end

  defp parse_frequency(frequency) do
    case Integer.parse(frequency) do
      {num, _} -> num
      _ -> 0
    end
  end
end
