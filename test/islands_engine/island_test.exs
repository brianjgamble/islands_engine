defmodule IslandsEngine.IslandTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{Island, Coordinate}

  test "new/2 creates a new island struct" do
    {:ok, coordinate} = Coordinate.new(4, 6)
    {:ok, island} = Island.new(:l_shape, coordinate)

    assert Enum.count(island.coordinates) == 4
    assert Enum.at(island.coordinates, 0) ==
      %Coordinate{col: 6, row: 4}

    assert Enum.empty?(island.hit_coordinates)
  end

  test "new/2 returns an error with an invalid island" do
    {:ok, coordinate} = Coordinate.new(4, 6)

    assert {:error, :invalid_island_type} = Island.new(:wrong, coordinate)
  end

  test "new/2 returns an error with an invalid coordinate" do
    {:ok, coordinate} = Coordinate.new(10, 10)

    assert {:error, :invalid_coordinate} = Island.new(:l_shape, coordinate)
  end

  defp square_island do
    {:ok, square_coordinate} = Coordinate.new(1, 1)
    {:ok, square} = Island.new(:square, square_coordinate)
    square
  end

  defp dot_island do
    {:ok, dot_coordinate} = Coordinate.new(1, 2)
    {:ok, dot} = Island.new(:dot, dot_coordinate)
    dot
  end

  defp l_shape_island do
    {:ok, l_shape_coordinate} = Coordinate.new(5, 5)
    {:ok, l_shape} = Island.new(:l_shape, l_shape_coordinate)
    l_shape
  end

  test "overlaps?/2 returns true when islands overlap" do
    square = square_island()
    dot    = dot_island()

    assert Island.overlaps?(square, dot)
  end

  test "overlaps?/2 returns false when islands don't overlap" do
    square  = square_island()
    dot     = dot_island()
    l_shape = l_shape_island()

    refute Island.overlaps?(square, l_shape)
    refute Island.overlaps?(dot, l_shape)
  end
end
