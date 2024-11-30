defmodule Kenneth.Positional.SingleRunoff do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    voters = DF.n_rows(ballots)
    pass = div(voters, 2)

    participants =
      for {candidate, s} <- DF.to_series(ballots) do
        result = s |> S.equal(1) |> S.sum()

        {candidate, result}
      end
      |> Enum.sort_by(&(-elem(&1, 1)))
      |> Enum.take(2)

    case participants do
      [{name, _}] ->
        name

      [{a, result}, _] when result > pass ->
        a

      [{a, _}, {b, _}] ->
        runoff(ballots, a, b, pass)
    end
  end

  defp runoff(ballots, a, b, pass) do
    a_over_b = S.less(ballots[a], ballots[b]) |> S.sum()

    if a_over_b > pass do
      a
    else
      b
    end
  end
end
