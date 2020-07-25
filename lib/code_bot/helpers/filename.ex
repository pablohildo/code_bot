defmodule CodeBot.Helpers.Filename do
  def get(lang) do
    case lang do
      "elixir" -> "main.ex"
      "elm" -> "main.elm"
      "ocaml" -> "main.ml"
      "haskell" -> "main.hs"
      "clojure" -> "main.clj"
      "scala" -> "main.scala"
      "fsharp" -> "main.fs"
      "rust" -> "main.rs"
      "idris" -> "main.idr"
    end
  end
end
