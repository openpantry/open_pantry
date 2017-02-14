class Stock < ApplicationRecord
  belongs_to :food
  belongs_to :meal
  belongs_to :offer
  belongs_to :facility
end
