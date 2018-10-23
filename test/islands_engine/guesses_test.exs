defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.{Coordinate, Guesses}

  test "new/0 creates a new guesses struct" do
    %Guesses{hits: hits, misses: misses} = Guesses.new()
    assert Enum.empty?(hits)
    assert Enum.empty?(misses)
  end

  test "add/3 allows hits to be tracked" do
    guesses = Guesses.new()
    {:ok, coordinate1} = Coordinate.new(8, 3)
    {:ok, coordinate2} = Coordinate.new(9, 7)

    guesses =
      guesses
      |> Guesses.add(:hit, coordinate1)
      |> Guesses.add(:hit, coordinate2)

    assert Enum.count(guesses.hits) == 2
    assert MapSet.equal?(MapSet.new([coordinate1, coordinate2]),
                         guesses.hits)
  end

  test "add/3 allows misses to be tracked" do
    guesses = Guesses.new()
    {:ok, coordinate} = Coordinate.new(1, 2)

    guesses = Guesses.add(guesses, :miss, coordinate)

    assert Enum.count(guesses.misses) == 1
    assert MapSet.equal?(MapSet.new([coordinate]), guesses.misses)
  end
end
