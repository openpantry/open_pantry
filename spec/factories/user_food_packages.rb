FactoryGirl.define do
  factory :user_food_package do
    ready_for_pickup false
    finalized false
    user nil
    inserted_at "2017-02-14 01:00:11"
  end
end
