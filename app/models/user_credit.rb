class UserCredit < ApplicationRecord
  belongs_to :user
  belongs_to :credit_type
end
