defmodule IslandsEngine.BoardTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{Board, Coordinate, Island}

  def square_island do
    {:ok, square_coordinate} = Coordinate.new(1, 1)
    {:ok, square} = Island.new(:square, square_coordinate)
    square
  end

  def dot_island do
    {:ok, dot_coordinate} = Coordinate.new(2, 2)
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
      |> Board.position_island(:square, square_island())

    placed_island = board.square
    {:ok, first_coordinate} = Coordinate.new(1, 1)

    assert MapSet.member?(placed_island.coordinates, first_coordinate)
  end

  test "position_island/3 prevents islands from overlapping" do
    board =
      Board.new
      |> Board.position_island(:square, square_island())

    assert Board.position_island(board, :dot, dot_island()) ==
      {:error, :overlapping_island}
  end
end
