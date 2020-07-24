defmodule CodeBot.Consumer do
  use Nostrum.Consumer

  alias CodeBot.Consumer.{
    MessageCreate
  }

  @spec start_link :: Supervisor.on_start()
  def start_link do
    Consumer.start_link(__MODULE__, max_restarts: 0)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    MessageCreate.handle(msg)
  end

  def handle_event({_, _ , _}) do
  end
end
