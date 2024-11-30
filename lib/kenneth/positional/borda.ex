defmodule Kenneth.Positional.Borda do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    for {candidate, s} <- DF.to_series(ballots) do
      sum = S.sum(s)

      {candidate, sum}
    end
    |> Enum.min_by(&elem(&1, 1))
    |> elem(0)
  end
end
