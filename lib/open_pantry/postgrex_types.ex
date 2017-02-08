Postgrex.Types.define(OpenPantry.PostgresTypes,
              [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
              json: Poison)


defimpl ExAdmin.Render, for: Geo.Point do
  def to_string(nil), do: ""
  def to_string(point) do
    {longitude, latitude} = point.coordinates
    "http://maps.google.com/?q=#{latitude},#{longitude}"
  end
end

# defimpl ExAdmin.Render, for: {:map, :credits} do
defimpl ExAdmin.Render, for: Any do
  def to_string(nil), do: ""
  def to_string(map) do
    map
    |> Enum.map(fn({name, val}) -> "#{Atom.to_string(name)}:  #{val}" end )
    |> Enum.join("\n")
  end
end

# usless but tried this also, think it's outdated/unneeded but dunnno
# defmodule OpenPantry.JSON do
#   @behaviour Ecto.Type

#   def type, do: :json
#   def cast(value), do: {:ok, value}
#   def blank?(_), do: false

#   def load(value) do
#     {:ok, value}
#   end

#   def dump(value) do
#     {:ok, value}
#   end
# end