defmodule Blank do
  @moduledoc """
  Tools around checking and handling undefined or blank data.
  """

  @doc """
  Returns `true` if data is considered blank/empty.

  ## Examples

    iex> Blank.blank? ""  # empty is the only blank string
    true

    iex> Blank.blank? " "  # not even whitespace-only is blank
    false

    iex> Blank.blank? "hello, world!"
    false

    iex> Blank.blank? 0  # integers are never blank, not even 0
    false

    iex> Blank.blank? 1
    false

    # (other types of numbers have not been implemented yet)

    iex> Blank.blank? []  # empty is the only blank list
    true

    iex> Blank.blank? [:foo]
    false

    iex> Blank.blank? [[]]  # having only blank elements doesn't make a list blank
    false

    iex> Blank.blank? %{}  # empty is the only blank map
    true

    iex> Blank.blank? %{ foo: :bar }
    false

    iex> Blank.blank? %{ "" => "" }  # blank keys/values don't make a map blank
    false

    iex> Blank.blank? false  # false and nil are the only blank atoms
    true

    iex> Blank.blank? nil
    true

    iex> Blank.blank? true
    false

    iex> Blank.blank? :any_other_atom
    false
  """
  def blank?(data) do
    Blank.Protocol.blank?(data)
  end

  @doc """
  Returns `true` if data is not considered blank/empty.
  
  ## Examples

    iex> Blank.present? ""  # empty is the only blank string
    false

    iex> Blank.present? " "  # not even whitespace-only is blank
    true

    iex> Blank.present? "hello, world!"
    true

    iex> Blank.present? 0  # integers are never blank, not even 0
    true

    iex> Blank.present? 1
    true

    # (other types of numbers have not been implemented yet)

    iex> Blank.present? []  # empty is the only blank list
    false

    iex> Blank.present? [:foo]
    true

    iex> Blank.present? [[]]  # having only blank elements doesn't make a list blank
    true

    iex> Blank.present? %{}  # empty is the only blank map
    false

    iex> Blank.present? %{ foo: :bar }
    true

    iex> Blank.present? %{ "" => "" }  # blank keys/values don't make a map blank
    true

    iex> Blank.present? false  # false and nil are the only blank atoms
    false

    iex> Blank.present? nil
    false

    iex> Blank.present? true
    true

    iex> Blank.present? :any_other_atom
    true
  """
  def present?(data) do
    !blank?(data)
  end

  @doc """
  Returns the provided `data` if present (according to `Blank.present?`),
  else the `default` value.

  ## Examples

    iex> Blank.default_to("", 42)
    42

    iex> Blank.default_to("hello, world!", 42)
    "hello, world!"
  """
  def default_to(data, default) do
    if blank?(data), do: default, else: data
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
