class Facility < ApplicationRecord
  has_many :users
  has_many :stocks
  has_many :user_food_packages, through: :users
  has_many :stock_distributions, through: :user_food_packages
end
