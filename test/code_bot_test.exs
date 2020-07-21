defmodule CodeBotTest do
  use ExUnit.Case
  doctest CodeBot

  test "greets the world" do
    assert CodeBot.hello() == :world
  end
end
