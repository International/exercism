defmodule Acronym do
  @doc """
  Generate an acronym from a string. 
  "This is a string" => "TIAS"
  """
  @spec abbreviate(string) :: String.t()
  def abbreviate(string) do
    # HyperText Markup Language
    Regex.scan(~r/[A-Z][a-z]+|[a-z]+(?=[A-Z]+)|\w+/, string) |> 
    Enum.map(fn [word] -> 
      String.at(word, 0) |> String.capitalize 
    end) |> Enum.join
  end
end
