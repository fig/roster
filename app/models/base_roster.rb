# Base Roster, used to generate personal rosters
class BaseRoster < ActiveRecord::Base
  has_many(:lines)
end
