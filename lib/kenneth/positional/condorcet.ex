defmodule Kenneth.Positional.Condorcet do
  @moduledoc """
  Condorcet's method - each candidate competes against others, if someones wins
  all 1:1 rounds, then is a general winner.
  """
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    candidates = DF.names(ballots)
    voters = DF.n_rows(ballots)
    pass = div(voters, 2)

    Enum.find(candidates, fn a ->
      Enum.all?(candidates, &wins_round?(ballots, a, &1, pass))
    end)
  end

  # Always win against ourselves, to simplify things
  defp wins_round?(_ballots, a, a, _pass), do: true

  defp wins_round?(ballots, a, b, pass) do
    a_over_b = S.less(ballots[a], ballots[b]) |> S.sum()

    a_over_b > pass
  end
end
