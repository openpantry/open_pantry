class User < ApplicationRecord
  belongs_to :facility
  belongs_to :primary_language, class_name: "Language"
  has_many :user_food_packages
end
