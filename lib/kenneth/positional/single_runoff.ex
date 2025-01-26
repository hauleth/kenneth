defmodule Kenneth.Positional.SingleRunoff do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    voters = DF.n_rows(ballots)
    pass = div(voters, 2)

    participants =
      ballots
      |> DF.pivot_longer(DF.names(ballots), names_to: "candidate")
      |> DF.mutate(value: value == 1)
      |> DF.group_by("candidate")
      |> DF.summarise(votes: S.sum(value))
      |> DF.sort_by(desc: votes)
      |> DF.head(2)
      |> DF.to_rows(atom_keys: true)

    case participants do
      [%{candidate: name}] ->
        name

      [%{candidate: a, votes: result}, _] when result > pass ->
        a

      [%{candidate: a}, %{candidate: b}] ->
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
