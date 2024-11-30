defmodule Kenneth.Cardinal.ScoreMean do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    for {candidate, s} <- DF.to_series(ballots) do
      result = S.mean(s)

      {candidate, result}
    end
    |> Enum.max_by(&elem(&1, 1))
    |> elem(0)
  end
end
