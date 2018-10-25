defmodule IslandsEngine.RulesTest do
  use ExUnit.Case, async: true

  alias IslandsEngine.Rules

  test "new/0 creates a new struct" do
    rules = Rules.new()
    assert rules.state == :initialized
  end
end
