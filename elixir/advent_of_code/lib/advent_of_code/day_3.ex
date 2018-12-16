defmodule AdventOfCode.Day3 do
  defstruct [:id, :x, :y, :width, :height]

  @type t :: %__MODULE__{
          id: integer,
          x: integer,
          y: integer,
          width: integer,
          height: integer
        }

  @type coordinate :: {integer, integer}

  @spec claimed_square_inches([binary]) :: integer
  def claimed_square_inches([]), do: 0

  def claimed_square_inches(claims) when is_list(claims) do
    claims
    |> process_claim_overlaps()
    |> Map.to_list()
    |> count_overlaps()
  end

  @spec process_claim_overlaps([binary]) :: map
  defp process_claim_overlaps(claims) do
    Enum.reduce(claims, %{}, fn claim, overlaps ->
      claim
      |> parse_claim()
      |> get_coordinates()
      |> store_overlaps(overlaps)
    end)
  end

  @spec parse_claim(binary) :: t
  defp parse_claim(claim) do
    captures =
      ~r/\A#(?<id>\d+)\s@\s(?<x>\d+),(?<y>\d+):\s(?<width>\d+)x(?<height>\d+)/
      |> Regex.named_captures(claim)
      |> Enum.map(fn
        {name, coord} when name in ~w[x y] ->
          {String.to_existing_atom(name), String.to_integer(coord) + 1}

        {name, val} ->
          {String.to_existing_atom(name), String.to_integer(val)}
      end)

    struct(__MODULE__, captures)
  end

  @spec get_coordinates(t) :: [{integer, integer}]
  defp get_coordinates(%__MODULE__{x: x, y: y, width: width, height: height}) do
    Enum.reduce(x..(x + width - 1), [], fn x_coord, coords ->
      Enum.reduce(y..(y + height - 1), coords, fn y_coord, coords ->
        [{x_coord, y_coord} | coords]
      end)
    end)
  end

  @spec store_overlaps([coordinate], map) :: map
  defp store_overlaps([], overlaps), do: overlaps

  defp store_overlaps([coordinate | coordinates], overlaps) do
    overlaps = Map.update(overlaps, coordinate, 1, &(&1 + 1))
    store_overlaps(coordinates, overlaps)
  end

  @spec count_overlaps([{any(), integer}]) :: integer
  defp count_overlaps([]), do: 0

  defp count_overlaps([{_coord, overlaps} | claims]) when overlaps > 1 do
    count_overlaps(claims) + 1
  end

  defp count_overlaps([_ | claims]) do
    count_overlaps(claims)
  end
end
