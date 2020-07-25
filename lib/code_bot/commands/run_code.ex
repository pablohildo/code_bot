defmodule CodeBot.Commands.RunCode do
  alias Nostrum.Api
  alias CodeBot.Helpers.Filename
  alias CodeBot.Helpers.Outputs
  alias Nostrum.Struct.Embed

  def description do
    %Embed{
      title: "Running Code",
      description:
      """
        This command runs code blocks given by users. Supported languages are, for now:
        - Elixir
        - Elm
        - Ocaml
        - Haskell
        - Clojure
        - Scala
        - F#
        - Rust
        - Idris

        **Usage**
        ```
        =run `​`​`language
          Your code goes here. Remember to output what you want to see.
          `​`​`
        ```
      """,
      color: 0x615CF2
    }
  end

  def command(msg, _user, code) do
    Api.create_message(msg.channel_id, "Ok, I got ya! Give me a second")

    [language, runnable] = String.trim(code, "`") |> String.split("\n", parts: 2)

    result = Mojito.post(
      "https://run.glot.io/languages/#{language}/latest",
      [{"content-type", "application/json"},
      {"authorization", "Token " <> Application.get_env(:code_bot, :token)}],
      Jason.encode!(%{"files" => [%{"name" => Filename.get(language), "content" => runnable}]}))

    case result do
      {:ok, response} ->
        Api.create_message(msg.channel_id, embed: output_message(Jason.decode!(response.body)))
      {:error, _} ->
        Api.create_message(msg.channel_id, Outputs.error("I think we're kinda dead right now :sob: Can you maybe try later?"))
    end
  end

  defp output_message(response) do
    case response do
      %{"error" => "", "stderr" => "", "stdout" => output} -> Outputs.success(output)
      %{"error" => "", "stderr" => output, "stdout" => ""} -> Outputs.expected_error(output)
      %{"error" => output, "stderr" => "", "stdout" => ""} -> Outputs.error(output)
      _-> :ignore
    end
  end
end
