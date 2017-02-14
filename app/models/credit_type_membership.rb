class CreditTypeMembership < ApplicationRecord
  belongs_to :food_group
  belongs_to :credit_type
end
