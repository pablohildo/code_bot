defmodule CodeBot.Commands.Help do
  alias Nostrum.Api
  alias CodeBot.Commands.RunCode

  def command(msg, comm) do
    message = case comm do
      "run" -> RunCode.description()
      _-> :ignore
    end
    Api.create_message(msg.channel_id, embed: message)
  end
end
