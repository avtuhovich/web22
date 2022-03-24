class Human < ApplicationRecord
  has_many :values, dependent: :destroy
end
