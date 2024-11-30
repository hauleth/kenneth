defmodule Kenneth do
  @moduledoc """
  Documentation for `Kenneth`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Kenneth.hello()
      :world

  """
  def hello do
    :world
  end

  @callback valid_vote?(map(), [term()]) :: boolean()
  @callback select_winner(term(), [term()]) :: term() | nil

  defstruct votes: [], candidates: []

  def add_votes(%__MODULE__{} = election, votes) when is_list(votes) do
    %__MODULE__{election | votes: votes ++ election.votes}
  end

  def winner(%__MODULE__{} = election, method) do
    if Enum.all?(election.votes, &method.valid_vote?(&1, election.candidates)) do
      method.select_winner(election.votes)
    else
      :error
    end
  end
end
