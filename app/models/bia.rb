class Bia < ApplicationRecord
  belongs_to :agent

  has_many :photos
  validates :name, presence: true

  scope :find_by_agency, ->(id) {where :agent_id => id}
end
