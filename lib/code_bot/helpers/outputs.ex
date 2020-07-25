defmodule CodeBot.Helpers.Outputs do
  alias Nostrum.Struct.Embed

  def error(message) do
    %Embed{
      title: "Error!",
      description: message,
      color: 0xEF4940
    }
  end

  def expected_error(message) do
    %Embed{
      title: "Expected Error (stderr)",
      description: message,
      color: 0xFCF816
    }
  end

  def success(message) do
    %Embed{
      title: "Success! Output",
      description: message,
      color: 0x45DB2E
    }
  end
end
