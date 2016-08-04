class Line < ActiveRecord::Base
  has_and_belongs_to_many(:turns)
  belongs_to(:base_roster)
  validates :number, presence: true
end
