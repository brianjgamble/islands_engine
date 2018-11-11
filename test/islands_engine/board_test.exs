defmodule IslandsEngine.BoardTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{Board, Coordinate, Island}

  def square_island(row, col) do
    {:ok, square_coordinate} = Coordinate.new(row, col)
    {:ok, square} = Island.new(:square, square_coordinate)
    square
  end

  def dot_island(row, col) do
    {:ok, dot_coordinate} = Coordinate.new(row, col)
    {:ok, dot} = Island.new(:dot, dot_coordinate)
    dot
  end

  test "new/0 create an empty map" do
    board = Board.new()
    assert Enum.empty?(Map.keys(board))
  end

  test "position_island/3 allows an island to be placed on the board" do
    board =
      Board.new
      |> Board.position_island(:square, square_island(1, 1))

    placed_island = board.square
    {:ok, first_coordinate} = Coordinate.new(1, 1)

    assert MapSet.member?(placed_island.coordinates, first_coordinate)
  end

  test "position_island/3 prevents islands from overlapping" do
    board =
      Board.new
      |> Board.position_island(:square, square_island(1, 1))

    {:ok, coordinate} = Coordinate.new(2, 1)
    {:ok, overlapping_dot} = Island.new(:dot, coordinate)

    assert Board.position_island(board, :dot, overlapping_dot) ==
      {:error, :overlapping_island}
  end

  test "guess/2 handles a miss" do
    board =
      Board.new
      |> Board.position_island(:dot, dot_island(7, 1))

    {:ok, guess_coordinate} = Coordinate.new(2, 1)
    {result, _, _, _} = Board.guess(board, guess_coordinate)

    assert result == :miss
  end

  test "guess/2 handles a hit" do
    board =
      Board.new
      |> Board.position_island(:dot, dot_island(7, 1))

    {:ok, guess_coordinate} = Coordinate.new(7, 1)
    {result, type, _, _} = Board.guess(board, guess_coordinate)

    assert result == :hit
    assert type == :dot
  end

  test "guess/2 handles a win" do
    square = square_island(1, 1)
    square_with_all_hits = %{square | hit_coordinates: square.coordinates}

    board =
      Board.new
      |> Board.position_island(:dot, dot_island(7, 1))
      |> Board.position_island(:square, square_with_all_hits)

    {:ok, win_coordinate} = Coordinate.new(7, 1)
    {:hit, :dot, result, _} = Board.guess(board, win_coordinate)

    assert result == :win
  end
end
