class Agent < ApplicationRecord
  has_many :bias
  validates :name, presence: true
  validates :name, uniqueness: true
end
