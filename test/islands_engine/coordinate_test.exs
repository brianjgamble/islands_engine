defmodule IslandsEngine.CoordinateTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.Coordinate

  test "new/2 creates a new coordinate" do
    assert {:ok, %Coordinate{row: 1, col: 1}} ==
      Coordinate.new(1, 1)
  end

  test "new/2 returns an error with values that are off the board" do
    assert {:error, :invalid_coordinate} == Coordinate.new(-1, 1)
    assert {:error, :invalid_coordinate} == Coordinate.new(11, 1)
  end
end
