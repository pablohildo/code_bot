defmodule CodeBot.Helpers.Language do
  def normalize(input) do
    language = case input do
      "ml" -> "ocaml"
      "hs" -> "haskell"
      "clj" -> "clojure"
      "fs" -> "fsharp"
      "rs" -> "rust"
      "sh" -> "bash"
      "coffee" -> "coffeescript"
      "c++" -> "cpp"
      "cr" -> "crystal"
      "cs" -> "csharp"
      "erl" -> "erlang"
      "js" -> "javascript"
      "kt" -> "kotlin"
      "m" -> "mercury"
      "py" -> "python"
      "rb" -> "ruby"
      "ts" -> "typescript"
      _ -> :no_lang
    end
    case language do
      :no_lang -> {:error, :no_lang}
      _ -> {:ok, language}
    end
  end
  def filename(lang) do
    filename = case lang do
      "elixir" -> "main.ex"
      "elm" -> "main.elm"
      "ocaml" -> "main.ml"
      "haskell" -> "main.hs"
      "clojure" -> "main.clj"
      "scala" -> "main.scala"
      "fsharp" -> "main.fs"
      "rust" -> "main.rs"
      "idris" -> "main.idr"
      "bash" -> "main.sh"
      "c" -> "main.c"
      "coffeescript" -> "main.coffee"
      "cpp" -> "main.cpp"
      "crystal" -> "main.cr"
      "csharp" -> "main.cs"
      "d" -> "main.d"
      "erlang" -> "main.erl"
      "go" -> "main.go"
      "groovy" -> "main.groovy"
      "java" -> "main.java"
      "javascript" -> "main.js"
      "julia" -> "main.jl"
      "kotlin" -> "main.kt"
      "lua" -> "main.lua"
      "mercury" -> "main.m"
      "nim" -> "main.nim"
      "perl" -> "main.pl"
      "php" -> "main.php"
      "python" -> "main.py"
      "ruby" -> "main.rb"
      "swift" -> "main.swift"
      "typescript" -> "main.ts"
      _ -> :no_lang
    end
    case filename do
      :no_lang -> {:error, :no_lang}
      _ -> {:ok, filename}
    end
  end
end
