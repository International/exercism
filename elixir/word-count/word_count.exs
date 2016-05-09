defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    split_words(sentence) |>
    Enum.map(&String.downcase/1) |> 
    Enum.reduce(%{}, fn word, acc ->
      Dict.update acc, word, 1, &(&1 + 1)
    end)
  end

  defp split_words(sentence) do
    Regex.scan(~r/[\p{L}-0-9]+/u, sentence) |> List.flatten
  end
end