FactoryGirl.define do
  factory :stock do
    quantity 1
    arrival "2017-02-14 01:00:11"
    expiration "2017-02-14 01:00:11"
    reorder_quantity 1
    aisle "MyString"
    row "MyString"
    shelf "MyString"
    packaging "MyString"
    credits_per_package 1
    food nil
    meal nil
    offer nil
    facility nil
    inserted_at "2017-02-14 01:00:11"
  end
end
