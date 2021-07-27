defmodule EQRCode.Alphanumeric do

  # Encoding table sourced from: https://www.thonky.com/qr-code-tutorial/alphanumeric-table
  @lookup_table %{
    ?0 => 0,
    ?1 => 1,
    ?2 => 2,
    ?3 => 3,
    ?4 => 4,
    ?5 => 5,
    ?6 => 6,
    ?7 => 7,
    ?8 => 8,
    ?9 => 9,
    ?A => 10,
    ?B => 11,
    ?C => 12,
    ?D => 13,
    ?E => 14,
    ?F => 15,
    ?G => 16,
    ?H => 17,
    ?I => 18,
    ?J => 19,
    ?K => 20,
    ?L => 21,
    ?M => 22,
    ?N => 23,
    ?O => 24,
    ?P => 25,
    ?Q => 26,
    ?R => 27,
    ?S => 28,
    ?T => 29,
    ?U => 30,
    ?V => 31,
    ?W => 32,
    ?X => 33,
    ?Y => 34,
    ?Z => 35,
    32 => 36,
    ?$ => 37,
    ?% => 38,
    ?* => 39,
    ?+ => 40,
    ?- => 41,
    ?. => 42,
    ?/ => 43,
    ?: => 44,
  }

  @doc """
  Takes a string and encodes each pair of characters into an
  11 bit binary. If the string had an odd number of characters
  the last character is encoded as a 6 bit binary.

  More info: https://www.thonky.com/qr-code-tutorial/alphanumeric-mode-encoding

  ## Examples

    iex> EQRCode.Alphanumeric.from_binary("ABCD")
    <<57, 168, 41::size(6)>>

    iex> EQRCode.Alphanumeric.from_binary("ABC")
    <<57, 166, 0::size(1)>>

    iex> EQRCode.Alphanumeric.from_binary("AB")
    <<57, 5::size(3)>>

    iex> EQRCode.Alphanumeric.from_binary("A")
    <<10::size(6)>>

    iex> EQRCode.Alphanumeric.from_binary("")
    ""

  """
  @spec from_binary(binary()) :: binary()
  def from_binary(<<one, two, rest::binary>>) do
    value = (45 * @lookup_table[one]) + @lookup_table[two]
    <<value::11, from_binary(rest)::bitstring >>
  end

  def from_binary(<<one>>), do: <<@lookup_table[one]::6>>
  def from_binary(<<>>), do: <<>>
end
