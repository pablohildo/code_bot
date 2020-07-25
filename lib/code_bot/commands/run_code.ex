defmodule CodeBot.Commands.RunCode do
  alias Nostrum.Api
  alias CodeBot.Helpers.Language
  alias CodeBot.Helpers.Outputs
  alias Nostrum.Struct.Embed
  import String

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
        - Bash
        - C
        - CoffeScript
        - C++
        - Crystal
        - C#
        - D
        - Erlang
        - Go
        - Groovy
        - Java
        - Javascript
        - Julia
        - Kotlin
        - Lua
        - Mercury
        - Nim
        - Perl
        - PHP
        - Python
        - Ruby
        - Swift
        - Typescript

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
    [input_language, runnable] = trim_leading(code) |> trim("`") |> split("\n", parts: 2)
    IO.puts(input_language)
    with {:ok, language} <- Language.normalize(input_language),
        {:ok, filename} <- Language.filename(language),
        {:ok, response} <- run_code(filename, language, runnable) do
          Api.create_message(msg.channel_id, embed: output_message(Jason.decode!(response.body)))
    else
      {:error, :no_lang} ->
        result = Api.create_message(msg.channel_id, embed: Outputs.warning("We don't support this language right now... Maybe ask someone to implement it :laughing:? I'm on Github as 'pablohildo/code_bot'"))
        IO.inspect(result)
      {:error, _} ->
        Api.create_message(msg.channel_id, embed: Outputs.error("I think we're kinda dead right now :sob: Can you maybe try later?"))
    end
  end

  defp run_code(filename, language, runnable) do
    Mojito.post(
      "https://run.glot.io/languages/#{language}/latest",
      [{"content-type", "application/json"},
      {"authorization", "Token " <> Application.get_env(:code_bot, :token)}],
      Jason.encode!(%{"files" => [%{"name" => filename, "content" => runnable}]}))
  end

  defp output_message(response) do
    case response do
      %{"error" => "", "stderr" => "", "stdout" => output} -> Outputs.success(output)
      %{"error" => _, "stderr" => output, "stdout" => ""} -> Outputs.error(output)
      _-> :ignore
    end
  end
end
