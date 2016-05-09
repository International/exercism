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

  def rle_pairing(string) do
    Regex.scan(~r/(.(?=\1+)?)/, string) |> 
    Enum.reduce {}, fn [letter, _], acc ->
      Tuple.append(acc, {1, letter})
    end
  end

  def rle_word(string) do
    original_ordering = rle_pairing(string) |> Tuple.to_list
    count_dict = Enum.reduce(original_ordering, %{}, fn {count, letter}, acc ->
      
      {_ign, new_map} = Map.get_and_update(acc, letter, fn val ->
        {val, (val || 0) + count}
      end)
      
      new_map
    end)

    original_ordering |> Enum.uniq |> Enum.reduce("", fn {_count, letter}, sacc ->
      sacc <> to_string(Map.get(count_dict, letter)) <> letter
    end)
  end
end