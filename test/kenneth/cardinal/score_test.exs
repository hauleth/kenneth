defmodule Kenneth.Cardinal.ScoreTest do
  use ExUnit.Case, async: false

  require Explorer.DataFrame, as: DF

  @subject Kenneth.Cardinal.Score

  doctest @subject

  test "everyone approves only one candidate" do
    ballots =
      DF.new(
        a: [1, 1, 1, 1, 1],
        b: [0, 0, 0, 0, 0],
        c: [0, 0, 0, 0, 0]
      )

    assert "a" == @subject.winner(ballots)
  end

  test "secondary candidate do not change result" do
    ballots =
      DF.new(
        a: [1, 1, 1, 1, 1],
        b: [1, 1, 1, 0, 0],
        c: [0, 0, 1, 1, 1]
      )

    assert "a" == @subject.winner(ballots)
  end

  test "loved by minority, but hated by rest" do
    ballots =
      DF.new(
        a: [5, 5, 5, 0, 0, 0, 0],
        c: [0, 0, 0, 3, 4, 4, 4]
      )

    assert "a" == @subject.winner(ballots)
  end
end
