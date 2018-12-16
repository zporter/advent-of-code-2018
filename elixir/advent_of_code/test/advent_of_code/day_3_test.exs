defmodule AdventOfCode.Day3Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day3

  setup do
    puzzle_input =
      "day3"
      |> AdventOfCode.Test.PuzzleInput.read!()
      |> String.split("\n", trim: true)

    [input: puzzle_input]
  end

  test "square inches of fabric with two or more claims", %{input: input} do
    example =
      """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """
      |> String.split("\n", trim: true)
      |> Day3.claimed_square_inches()

    assert example == 4

    assert Day3.claimed_square_inches(input) == 115_348
  end
end
