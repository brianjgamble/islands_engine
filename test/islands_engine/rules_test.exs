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

  test "check/2 allows a player to position islands when not set" do
    rules = Rules.new()
    rules = %{rules | state: :players_set}

    {:ok, rules} = Rules.check(rules, {:position_islands, :player1})
    assert rules.state == :players_set
  end

  test "check/2 does not allow the positioning of islands when set" do
    rules = Rules.new()
    rules = %{rules | state: :players_set, player1: :islands_set}

    assert Rules.check(rules, {:position_islands, :player1}) ==
      :error
  end

  test "check/2 when islands are set it's player1 turn" do
    rules = Rules.new()
    rules = %{rules | state: :players_set}

    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})

    assert rules.state == :player1_turn
  end
end
