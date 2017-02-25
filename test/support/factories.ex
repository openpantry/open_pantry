defmodule OpenPantry.Factory do
  use ExMachina.Ecto, repo: OpenPantry.Repo

  def user_factory do
    %OpenPantry.User{
      name: "Jane Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      family_members: 1,
      primary_language: build(:language),
      facility: build(:facility)
    }
  end

  def language_factory do
    %OpenPantry.Language{
      iso_code: sequence(:language, &"fake_iso_code-#{&1}"),
      english_name: sequence(:language, &"fake_english_name-#{&1}"),
      native_name: sequence(:language, &"fake_native_name-#{&1}")
    }
  end

  def facility_factory do
    %OpenPantry.Facility{
      name: sequence(:facility_name, &"facility-#{&1}")
    }
  end

  def food_factory do
    %OpenPantry.Food{
      ndb_no: sequence(:ndb_no, &"0#{&1}"),
      longdesc: sequence(:longdesc, &"longdesc-#{&1}"),
      shortdesc: sequence(:shortdesc, &"shortdesc-#{&1}"),
      food_group: build(:food_group)
    }
  end

  def food_group_factory do
    %OpenPantry.FoodGroup{
      foodgroup_code: sequence(:foodgroup_code, &"#{&1}00"),
      foodgroup_desc: sequence(:foodgroup_desc, &"foodgroup_desc-#{&1}")
    }
  end

  def stock_factory do
    %OpenPantry.Stock{
      quantity: 20,
      credits_per_package: 1,
      packaging: sequence(:packaging, &"packaging-#{&1}"),
      facility: build(:facility),
      food: build(:food)
    }
  end

  def credit_type_factory do
    %OpenPantry.CreditType{
      name: sequence(:credit_type_name, &"credit_type_name-#{&1}"),
      credits_per_period: 18,
      period_name: sequence(:period_name, &"period_name-#{&1}"),
      food_groups: [build(:food_group)]
    }
  end

  def user_credit_factory do
    %OpenPantry.UserCredit{
      balance: 18,
      user: build(:user),
      credit_type: build(:credit_type)
    }
  end

end