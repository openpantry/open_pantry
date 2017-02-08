defmodule OpenPantry.ExAdmin.User do
  use ExAdmin.Register
  alias OpenPantry.Repo
  alias OpenPantry.FoodGroup

  import OpenPantry.Repo
  import OpenPantry.FoodGroup
  register_resource OpenPantry.User do

    # controller do
    #   before_filter :decode, only: [:update, :create, :edit, :new]

    #   def decode(conn, params) do
    #     if get_in params, [:user, :credits] do
    #       params = update_in params, [:user, :credits], &(Poison.decode!(&1))
    #     end
    #     {conn, params}
    #   end
    # end
    # show(user) do
    #   attributes_table except: [:credits]
    #   panel "Credits" do
    #     table_for user.credits do
    #       Repo.all(FoodGroup) |> Enum.map(&({&1.name, &1.monthly_credits}))
    #     end
    #   end
    # end

    form user do
      inputs "User Details" do
        input user, :name
        input user, :email
        input user, :primary_language
        input user, :facility
        input user, :address1
        input user, :address1
        input user, :address2
        input user, :city
        input user, :region
        input user, :postal_code
      end
      inputs "Credits" do
        input user, :credits, schema: Repo.all(FoodGroup) |> Enum.map(&({&1.name |> String.to_atom, :integer}))
      end
    end

    # edit(user) do
    #   attributes_table except: [:credits]
    #   panel "Credits" do
    #     table_for user.credits do
    #       # Repo.all FoodGroup
    #     end
    #   end
    # end

    # new(user) do
    #   attributes_table except: [:credits]
    #   panel "Credits" do
    #     table_for user.credits do
    #       # Repo.all FoodGroup
    #     end
    #   end
    # end
  end
end
