defmodule AdventOfCode.Test.PuzzleInput do
  @spec read!(binary) :: binary
  def read!(file_name) do
    File.read!("test/puzzle_inputs/#{file_name}")
  end
end
