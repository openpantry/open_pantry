defmodule OpenPantry.ExAdmin.User do
  use ExAdmin.Register
  alias OpenPantry.Repo
  alias OpenPantry.CreditType

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
      column :facility
    end
    show user do
      attributes_table all: [:true] #  all: true

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


    end
  end
end
