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

  test "check/2 returns an error with the wrong action" do
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

  test "check/2 prevents the positioning of islands when set" do
    rules = Rules.new()
    rules = %{rules | state: :players_set, player1: :islands_set}

    assert Rules.check(rules, {:position_islands, :player1}) ==
      :error
  end

  test "check/2 set turn to player1 when islands are set" do
    rules = Rules.new()
    rules = %{rules | state: :players_set}

    {:ok, rules} = Rules.check(rules, {:set_islands, :player1})
    {:ok, rules} = Rules.check(rules, {:set_islands, :player2})

    assert rules.state == :player1_turn
  end

  test "check/2 allows player1 to guess a coordinate" do
    rules = Rules.new()
    rules = %{rules | state: :player1_turn}

    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player1})
    assert rules.state == :player2_turn
  end

  test "check/2 prevents a player guess out of turn" do
    rules = Rules.new()
    rules = %{rules | state: :player1_turn}

    assert Rules.check(rules, {:guess_coordinate, :player2}) ==
      :error
  end

  test "check/2 sets game over when a player1 wins" do
    rules = Rules.new()
    rules = %{rules | state: :player1_turn}

    {:ok, rules} = Rules.check(rules, {:win_check, :win})
    assert rules.state == :game_over
  end

  test "check/2 allows player2 to guess a coordinate" do
    rules = Rules.new()
    rules = %{rules | state: :player2_turn}

    {:ok, rules} = Rules.check(rules, {:guess_coordinate, :player2})
    assert rules.state == :player1_turn
  end

  test "check/2 sets game over when a player2 wins" do
    rules = Rules.new()
    rules = %{rules | state: :player2_turn}

    {:ok, rules} = Rules.check(rules, {:win_check, :win})
    assert rules.state == :game_over
  end
end
