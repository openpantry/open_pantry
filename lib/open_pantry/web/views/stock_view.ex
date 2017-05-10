defmodule OpenPantry.Web.StockView do
  use OpenPantry.Web, :view

  def food_list do
    OpenPantry.Food.all([:food_group, :credit_types])
    |> Enum.map(&({"#{&1.longdesc} - #{&1.food_group.foodgroup_desc}", &1.ndb_no}))
  end

  def facility_list do
    OpenPantry.Facility.all()
    |> Enum.map(&({&1.name, &1.id}))
  end
end
