defmodule CodeBot.Consumer.MessageCreate do

  alias CodeBot.Commands.{ RunCode, Help }

  @spec handle(Message.t()) :: :ok | nil
  def handle(msg) do
    unless msg.author.bot do
      case msg.content do
        "=run " <> code -> # I feel so proud of this
          RunCode.command(msg, msg.author, code)
        "=run\n" <> code ->
          RunCode.command(msg, msg.author, code)
        "=help " <> command ->
          Help.command(msg, command)
        _->
          :ignore
      end
    end
  end
end
