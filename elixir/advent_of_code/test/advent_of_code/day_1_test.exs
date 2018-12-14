defmodule AdventOfCode.Day1Test do
  use ExUnit.Case, async: true

  alias AdventOfCode.Day1

  setup do
    puzzle_input =
      "day1"
      |> AdventOfCode.Test.PuzzleInput.read!()
      |> String.split("\n", trim: true)

    [input: puzzle_input]
  end

  test "get resulting frequency", %{input: input} do
    assert Day1.calc_frequencies(input) == 556
  end

  test "get duplicate frequency", %{input: input} do
    assert Day1.duplicate_frequency(input) == 448
  end
end
