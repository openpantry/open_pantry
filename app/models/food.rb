class Food < ApplicationRecord
  belongs_to :food_group, foreign_key: :foodgroup_code
  has_many :stocks
end
