defmodule Kenneth.Positional.HareTest do
  use ExUnit.Case, async: true

  alias Explorer.DataFrame, as: DF

  @subject Kenneth.Positional.Hare

  doctest @subject

  test "if everyone votes for single candidate, then they win" do
    ballots =
      DF.new(
        a: List.duplicate(1, 100),
        b: List.duplicate(2, 100),
        c: List.duplicate(3, 100)
      )

    assert "a" == @subject.winner(ballots)
  end

  test "if more than half of the voters select single candidate, they win" do
    ballots =
      DF.new(
        a: [1, 1, 1, 2, 3],
        b: [2, 3, 2, 1, 2],
        c: [3, 2, 3, 3, 1]
      )

    assert "a" == @subject.winner(ballots)
  end
end
