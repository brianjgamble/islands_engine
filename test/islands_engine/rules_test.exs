defmodule IslandsEngine.RulesTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.Rules

  test "new/0 returns an initialized struct" do
    rules = Rules.new()
    assert rules.state == :initialized
  end

  test "check/2 adding a player changes the state" do
    {:ok, rules} =
      Rules.new()
      |> Rules.check(:add_player)

    assert rules.state == :players_set
  end

  test "check/2 return an error with the wrong action" do
    result =
      Rules.new()
      |> Rules.check(:completely_wrong_action)

    assert result == :error
  end
end
