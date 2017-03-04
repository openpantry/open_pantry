Postgrex.Types.define(OpenPantry.PostgresTypes,
              [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
              json: Poison)

# defimpl ExAdmin.Render, for: Geo.Point do
#   def to_string(nil), do: ""
#   def to_string(point) do
#     {longitude, latitude} = point.coordinates
#     "http://maps.google.com/?q=#{latitude},#{longitude}"
#   end
# end