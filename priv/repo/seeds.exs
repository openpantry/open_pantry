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
alias OpenPantry.User
alias OpenPantry.CreditType
import Ecto.Query
import OpenPantry.Factory


facility_params = [
  %{name: "Flatbush",
    subdomain: "flatbush",
    max_occupancy: 100,
    address1: "1372 Coney Island Ave",
    city: "Brooklyn",
    region: "NY",
    postal_code: "11230"
    },
  %{name: "Boro Park",
    subdomain: "boro-park",
    max_occupancy: 20,
    address1: "5402 New Utrecht Ave",
    city: "Brooklyn",
    region: "NY",
    postal_code: "11219"
    },
  %{name: "Queens",
    subdomain: "queens",
    max_occupancy: 50,
    address1: "98-08 Queens Blvd",
    city: "Queens",
    region: "NY",
    postal_code: "11374"
  }
]

credit_type_params = [
  %{name: "Protein",
    credits_per_period: 18,
    period_name: "Month"
    },
  %{name: "Veggies",
    credits_per_period: 18,
    period_name: "Month"
    },
  %{name: "Carbs",
    credits_per_period: 18,
    period_name: "Month"
  }
]

facilities = Enum.map(facility_params, fn(params) ->
  Facility.changeset(%Facility{}, params)
  |> Repo.insert!()
end)

credit_types = Enum.map(credit_type_params, fn(params) ->
  CreditType.changeset(%CreditType{}, params)
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

guest = User.changeset(%User{}, %{name: "Anonymous",
                          family_members: 0,
                          primary_language_id: 184,
                          facility_id: 1,
                         })
        |> Repo.insert!()

demo =  User.changeset(%User{}, %{name: "Demo User",
                          family_members: 4,
                          primary_language_id: 184,
                          facility_id: 1,
                         })
        |> Repo.insert!()


for credit_type <- credit_types do
  insert(:user_credit, credit_type: credit_type, user: guest, balance: 0 )
  insert(:user_credit, credit_type: credit_type, user: demo )
end

food_groups = for _ <- 1..3 do
  insert(:food_group, credit_types: [Enum.random(credit_types)])
end

foods = for food_group <- food_groups do
  for _ <- 1..2 do
    insert(:food, food_group: food_group)
  end
end

Enum.each(facilities, fn(facility) ->
  for food_group_foods <- foods do
    for food <- food_group_foods do
      insert(:stock, facility: facility, food: food)
    end
  end
end)
