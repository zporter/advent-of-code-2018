defmodule AdventOfCode.Day2Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day2

  setup do
    puzzle_input =
      "day2"
      |> AdventOfCode.Test.PuzzleInput.read!()
      |> String.split("\n", trim: true)

    [input: puzzle_input]
  end

  test "getting checksum of box IDs", %{input: input} do
    assert Day2.checksum(input) == 7221
  end

  test "getting common letters", %{input: input} do
    example_input = ~w[
      abcde
      fghij
      klmno
      pqrst
      fguij
      axcye
      wvxyz
    ]

    assert Day2.common_letters(example_input) == "fgij"

    assert Day2.common_letters(input) == "mkcdflathzwsvjxrevymbdpoq"
  end
end
