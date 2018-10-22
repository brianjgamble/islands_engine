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
end
