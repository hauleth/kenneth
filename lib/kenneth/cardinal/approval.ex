defmodule Kenneth.Cardinal.Approval do
  require Explorer.DataFrame, as: DF
  require Explorer.Series, as: S

  def winner(ballots) do
    ballots
    |> DF.pivot_longer(DF.names(ballots), names_to: "candidate")
    |> DF.mutate(value: value == 1)
    |> DF.group_by("candidate")
    |> DF.summarise(votes: S.sum(value))
    |> DF.sort_by(desc: votes)
    |> DF.pull("candidate")
    |> S.to_list()
    |> List.first()
  end
end
