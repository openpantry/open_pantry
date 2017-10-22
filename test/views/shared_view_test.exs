defmodule OpenPantry.SharedViewTest do
  use ExUnit.Case

  describe "max_allowed" do

    test "if there's a max/pkg, we get that, even w/ a max/pn" do
      max = 123
      stock = %{ max_per_package: max, max_per_person: max * 2 }
      assert OpenPantry.Web.SharedView.max_allowed(stock, 4) == max
    end

    test "if no max/pkg, but max/pn, we get that X fam size" do
      max = 123
      stock = %{ max_per_package: nil, max_per_person: max }
      fam_size = 4
      exp = max * fam_size
      assert OpenPantry.Web.SharedView.max_allowed(stock, fam_size) == exp
    end

    test "if no max/pkg, and no max/pn, we get default" do
      stock = %{ max_per_package: nil, max_per_person: nil }
      assert OpenPantry.Web.SharedView.max_allowed(stock, 4) == 999
    end

  end

end
