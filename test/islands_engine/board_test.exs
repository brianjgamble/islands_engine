defmodule IslandsEngine.BoardTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.Board

  test "new/0 create an empty map" do
    map = Board.new()

    assert is_map(map)
    assert Enum.empty?(map)
  end
end
