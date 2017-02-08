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
alias OpenPantry.Facility
alias OpenPantry.Language
alias OpenPantry.Repo
alias OpenPantry.FoodGroup
alias OpenPantry.Food
alias OpenPantry.Stock
alias OpenPantry.User


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

food_group_params = [
  %{name: "Carbohydrates",
    monthly_credits: 40
    },
  %{name: "Protein",
    monthly_credits: 30
    },
  %{name: "Vegetables",
    monthly_credits: 50
  }
]

food_params = [
  %{name: "Potatoes", # https://g.co/kgs/nYXogy
    serving_size: 0.369,
    calories: 283,
    sodium: 22,
    carbohydrate: 64,
    sugars: 3,
    protein: 7,
    fiber: 8
    },

  %{name: "Spinach", # https://g.co/kgs/xWjQaO
    serving_size: 0.284,
    calories: 66,
    calcium: 0,
    sodium: 224,
    carbohydrate: 10,
    fat: 1,
    protein: 8,
    fiber: 6
    },

  %{name: "Tunafish", # http://nutritiondata.self.com/facts/finfish-and-shellfish-products/4146/2
    serving_size: 0.154,
    calories: 179,
    calories_from_fat: 11,
    sodium: 521,
    carbohydrate: 46,
    fat: 1,
    protein: 39
  }
]

User.changeset(%User{}, %{name: "Anonymous",
                          family_members: 1,
                          primary_language_id: 184,
                          facility_id: 1,
                          credits: %{
                            "Protein" => 30,
                            "Vegetables" => 50,
                            "Carbohydrates" => 40
                          }
                        })
|> Repo.insert!()

Enum.each(facility_params, fn(params) ->
  Facility.changeset(%Facility{}, params)
  |> Repo.insert!()
end)

Enum.each(food_group_params, fn(params) ->
  FoodGroup.changeset(%FoodGroup{}, params)
  |> Repo.insert!()
end)


Enum.each(food_params, fn(params) ->
  Food.changeset(%Food{}, params)
  |> Repo.insert!()
end)


File.read!("priv/repo/languages.json")
|> Poison.Parser.parse!
|> Enum.each(
    fn(language) ->
      Language.changeset(%Language{}, %{iso_code: language["code"], english_name: language["name"], native_name: language["nativeName"] })
      |> Repo.insert!()
    end
  )

if Mix.env == :dev do # keep fake data out of prod?



end

