defmodule Kenneth.Positional.Hare do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    voters = DF.n_rows(ballots)
    pass = div(voters, 2)

    do_round(ballots, pass)
  end

  # Compute round, if one candidate gained more than half of the 
  defp do_round(ballots, pass) do
    {{least, _}, {winner, score}} = round_results(ballots)

    if score > pass do
      winner
    else
      do_round(filter(ballots, least), pass)
    end
  end

  defp round_results(ballots) do
    for {candidate, s} <- DF.to_series(ballots) do
      result = s |> S.equal(1) |> S.sum()

      {candidate, result}
    end
    |> Enum.min_max_by(&elem(&1, 1))
  end

  defp filter(ballots, least) do
    others = DF.names(ballots) -- [least]

    DF.mutate_with(
      ballots,
      fn row ->
        for other <- others do
          # For each other candidate `c`:
          #
          # ranks[least] = if ranks[least] > ranks[c], do: ranks[least] - 1, else: ranks[least]
          {other, S.subtract(row[other], S.select(S.greater(row[other], row[least]), 1, 0))}
        end
      end,
      keep: :none
    )
  end
end
