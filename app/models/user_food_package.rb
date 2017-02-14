class UserFoodPackage < ApplicationRecord
  belongs_to :user
  has_many :stock_distributions
end
