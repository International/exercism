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
    Regex.scan(~r/\d+\D|\D/, string) |>
    List.flatten |>
    Enum.map(fn scan ->
      count = Regex.scan(~r/\d+/, scan) |>
              List.flatten |> Enum.at(0)
      if count == 0 do
        scan
      else
        String.duplicate(
          Regex.replace(~r/\d+(\D+)/, scan,"\\1"),
          String.to_integer(count)
        )
      end

    end) |>
    Enum.join
  end

  defp rle_pairing(string) do
    Regex.scan(~r/([a-zA-Z])\1*/, string) |>
    Enum.map(fn e -> Enum.take(e,1) end) |>
    List.flatten
  end

  defp rle_word(string) do
    rle_pairing(string) |> Enum.reduce("", fn word, sacc ->
      sacc <> to_string(String.length(word)) <> String.at(word, 0)
    end)
  end
end
