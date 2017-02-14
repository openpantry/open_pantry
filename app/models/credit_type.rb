class CreditType < ApplicationRecord
  has_many :credit_type_memberships
  has_many :food_groups, through: :credit_type_memberships
end
