defmodule Athena.Common.Slugify do
  def call(string) do
    string
    |> String.downcase()
    |> String.replace("_", "-")
    |> String.trim()
  end
end
