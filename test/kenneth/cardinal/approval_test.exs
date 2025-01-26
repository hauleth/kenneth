defmodule Kenneth.Cardinal.ApprovalTest do
  use ExUnit.Case, async: false
  require Explorer.DataFrame, as: DF

  @subject Kenneth.Cardinal.Approval

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
end
