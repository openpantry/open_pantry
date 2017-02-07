defmodule OpenPantry.ExAdmin.User do
  use ExAdmin.Register

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

  end
end
