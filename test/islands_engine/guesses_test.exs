defmodule IslandsEngine.GuessesTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.Guesses

  test "new/0 creates a new guesses struct" do
    %Guesses{hits: hits, misses: misses} = Guesses.new()
    assert Enum.empty?(hits)
    assert Enum.empty?(misses)
  end
end
