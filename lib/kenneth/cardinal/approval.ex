defmodule Kenneth.Cardinal.Approval do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    for {candidate, s} <- DF.to_series(ballots) do
      result = s |> S.equal(1) |> S.sum()

      {candidate, result}
    end
    |> Enum.max_by(&elem(&1, 1))
    |> elem(0)
  end
end
