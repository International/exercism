defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    case string do
      "" -> ""
      _ -> rle_word(string)
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do

  end

  defp rle_pairing(string) do
    Regex.scan(~r/(.(?=\1+)?)/, string) |> 
    Enum.group_by(fn [first,last] -> first end) |>
    Enum.reduce {}, fn {key, list}, acc ->
      Tuple.append(acc, {Enum.count(list), key})
    end
  end

  defp rle_word(string) do
    rle_pairing(string) |> Tuple.to_list |> Enum.map(&to_string/1) |> Enum.join
  end
end