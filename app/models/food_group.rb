class FoodGroup < ApplicationRecord
  has_many :foods, foreign_key: :foodgroup_code
end
