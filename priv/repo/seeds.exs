# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     OpenPantry.Repo.insert!(%OpenPantry.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
facility_params = [
  %{name: "Flatbush",
    max_occupancy: 100,
    location: %Geo.Point{coordinates: {-73.965288, 40.624061}},
    address1: "1372 Coney Island Ave",
    city: "Brooklyn",
    region: "NY",
    postal_code: "11230"
    },
  %{name: "Boro Park",
    max_occupancy: 20,
    location: %Geo.Point{coordinates: {-73.995519, 40.632360}},
    address1: "5402 New Utrecht Ave",
    city: "Brooklyn",
    region: "NY",
    postal_code: "11219"
    },
  %{name: "Queens",
    max_occupancy: 50,
    location: %Geo.Point{coordinates: {-73.858008, 40.728167}},
    address1: "98-08 Queens Blvd",
    city: "Queens",
    region: "NY",
    postal_code: "11374"
  }
]

Enum.each(facility_params, fn(params) ->
  OpenPantry.Facility.changeset(%OpenPantry.Facility{}, params)
  |> OpenPantry.Repo.insert!()
end)
