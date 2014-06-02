class Week < ActiveRecord::Base
  has_and_belongs_to_many :turns
end
