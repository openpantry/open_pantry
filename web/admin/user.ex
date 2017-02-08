defmodule OpenPantry.ExAdmin.User do
  use ExAdmin.Register
  alias OpenPantry.Repo
  alias OpenPantry.FoodGroup

  import OpenPantry.Repo
  import OpenPantry.FoodGroup
  register_resource OpenPantry.User do

    index do
      selectable_column
      column :id
      column :name
      column :email
      column :address1
      column :address2
      column :region
      column :postal_code
      column :primary_language
      column :credits
    end
    show user do
      attributes_table except: [:credits] #  all: true

      panel "Credits" do
        table_for user.credits do
          Repo.all(FoodGroup)
          |> Enum.each(fn(food_group) ->
            column food_group.name |> String.to_atom
          end)
        end
      end

    end
    form user do
      inputs "User Details" do
        input user, :name
        input user, :email
        input user, :address1
        input user, :address1
        input user, :address2
        input user, :city
        input user, :region
        input user, :postal_code
        # input user, :primary_language, OpenPantry.Language
        # input user, :facility, OpenPantry.facility
      end
      inputs "Credits" do
        input user, :credits, schema: Repo.all(FoodGroup) |> Enum.map(&({&1.name |> String.to_atom, :integer}))
      end


    end
  end
end
