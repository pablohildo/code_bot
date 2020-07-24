defmodule CodeBot.Consumer.MessageCreate do

  alias CodeBot.Commands.RunCode

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      case msg.content do
        "=run "<> code -> # I feel so proud of this
          RunCode.command(msg, msg.author, code)
        _->
          :ignore
      end
    end
  end
end
