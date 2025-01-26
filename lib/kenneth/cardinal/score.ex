defmodule Kenneth.Cardinal.Score do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    ballots
    |> DF.pivot_longer(DF.names(ballots), names_to: "candidate")
    |> DF.group_by("candidate")
    |> DF.summarise(votes: S.mean(value))
    |> DF.sort_by(desc: votes)
    |> DF.pull("candidate")
    |> S.to_list()
    |> List.first()
  end
end
