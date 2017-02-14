class StockDistribution < ApplicationRecord
  belongs_to :stock
  belongs_to :user_food_package
end
