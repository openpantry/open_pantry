defmodule Blank do
  @moduledoc """
  Tools around checking and handling undefined or blank data.
  """

  @doc """
  Returns `true` if data is considered blank/empty.
  What is considered blank?

  * Empty strings, empty lists, and empty maps
  * The atoms `false` and `nil`

  Everything else is non-blank.  That includes
  whitespace-only strings, and all integers, even 0.
  (Other types of numbers have not been implemented yet.)

  This was mostly adapted from
  https://gist.github.com/erikreedstrom/5104f5eea925cdece6e4 .

  ## Examples

    iex> Blank.blank? ""  # empty is the only blank string
    true

    iex> Blank.blank? " "  # note the space in there
    false

    iex> Blank.blank? []  # [] is the only blank list
    true

    iex> Blank.blank? %{}  # %{} is the only blank map
    true
  """
  def blank?(data) do
    Blank.Protocol.blank?(data)
  end

  @doc """
  Returns `true` if data is _not_ considered blank/empty.
  See the documentation on `blank?` for details.
  """
  def present?(data) do
    !blank?(data)
  end

end

defprotocol Blank.Protocol do
  @moduledoc """
  Provides only one single method definition `blank?/1`
  """

  @doc """
  Returns `true` if data is considered blank/empty.
  """
  def blank?(data)
end

# Integers are never blank
defimpl Blank.Protocol, for: Integer do
  def blank?(_), do: false
end

defimpl Blank.Protocol, for: BitString do
  def blank?(""), do: true
  def blank?(_), do: false
end

# Just empty list is blank
defimpl Blank.Protocol, for: List do
  def blank?([]), do: true
  def blank?(_), do: false
end

defimpl Blank.Protocol, for: Map do
  # Keep in mind we could not pattern match on %{} because
  # it matches on all maps. We can however check if the size
  # is zero (and size is a fast operation).
  def blank?(map), do: map_size(map) == 0
end

# Just the atoms false and nil are blank
defimpl Blank.Protocol, for: Atom do
  def blank?(false), do: true
  def blank?(nil), do: true
  def blank?(_), do: false
end
