defmodule AdventOfCode.Day2 do
  @doc """
  Late at night, you sneak to the warehouse - who knows what kinds of
  paradoxes you could cause if you were discovered - and use your fancy wrist
  device to quickly scan every box and produce a list of the likely candidates
  (your puzzle input).

  To make sure you didn't miss any, you scan the likely candidate boxes again,
  counting the number that have an ID containing exactly two of any letter and
  then separately counting those with exactly three of any letter. You can
  multiply those two counts together to get a rudimentary checksum and compare
  it to what your device predicts.

  For example, if you see the following box IDs:

  - abcdef contains no letters that appear exactly two or three times.
  - bababc contains two a and three b, so it counts for both.
  - abbcde contains two b, but no letter appears exactly three times.
  - abcccd contains three c, but no letter appears exactly two times.
  - aabcdd contains two a and two d, but it only counts once.
  - abcdee contains two e.
  - ababab contains three a and three b, but it only counts once.

  Of these box IDs, four of them contain a letter which appears exactly twice,
  and three of them contain a letter which appears exactly three times.
  Multiplying these together produces a checksum of 4 * 3 = 12.
  """
  @spec checksum([binary]) :: integer
  def checksum([]), do: 0

  def checksum(box_ids) when is_list(box_ids) do
    {twos, threes} = calc_checksums(box_ids)

    twos * threes
  end

  @spec calc_checksums([binary]) :: {integer, integer}
  defp calc_checksums([]), do: {0, 0}

  defp calc_checksums(box_ids) do
    Enum.reduce(box_ids, {0, 0}, fn box_id, {twos, threes} ->
      {two_count, three_count} = calc_checksum(box_id)

      {twos + two_count, threes + three_count}
    end)
  end

  @spec calc_checksum(binary) :: {integer, integer}
  defp calc_checksum(box_id) do
    box_id
    |> get_letter_counts()
    |> Map.values()
    |> Enum.reduce_while({0, 0}, fn count, {twos, threes} ->
      count
      |> case do
        2 when twos < 1 -> {twos + 1, threes}
        3 when threes < 1 -> {twos, threes + 1}
        _ -> {twos, threes}
      end
      |> case do
        {1, 1} = values -> {:halt, values}
        values -> {:cont, values}
      end
    end)
  end

  @spec get_letter_counts(binary) :: map
  defp get_letter_counts(box_id) do
    box_id
    |> String.codepoints()
    |> Enum.reduce(%{}, fn letter, counts ->
      Map.update(counts, letter, 1, &(&1 + 1))
    end)
  end

  @spec common_letters([binary]) :: binary
  def common_letters([]), do: ""

  def common_letters(box_ids) when is_list(box_ids) do
    box_ids
    # let's transform a list of binaries to a list of charlists.
    |> Enum.map(&String.codepoints/1)
    # now, let's find the common chars
    |> common_chars()
  end

  @spec common_chars([charlist()]) :: binary
  defp common_chars([box_id | box_ids]) do
    common_chars(box_id, box_ids) || common_chars(box_ids)
  end

  @spec common_chars(charlist, [charlist]) :: binary | nil
  defp common_chars(_box_id, []), do: nil

  defp common_chars(box_id, [other_box_id | box_ids]) do
    box_id
    # let's add an index to look up and compare with the character in the
    # other char list.
    |> Enum.with_index()
    # the first elem in the tuple tracks the number of different characters
    # encountered. the second elem tracks the common chars as a String.
    |> Enum.reduce_while({0, ""}, fn
      # halt when the diff is greater than 1.
      _char, {diff, _common} when diff > 1 ->
        {:halt, nil}

      # compare the characters. when the same, append to the String in the
      # tuple. when different, add to the diff count in the tuple.
      {char, index}, {diff, common} ->
        if Enum.at(other_box_id, index) == char do
          {:cont, {diff, common <> char}}
        else
          {:cont, {diff + 1, common}}
        end
    end)
    |> case do
      {diff, common} when diff < 2 -> common
      _ -> common_chars(box_id, box_ids)
    end
  end
end
