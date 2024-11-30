defmodule KennethTest do
  use ExUnit.Case
  doctest Kenneth

  test "greets the world" do
    assert Kenneth.hello() == :world
  end
end
