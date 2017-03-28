# == Schema Information
#
# Table name: base_rosters
#
#  id                :integer          not null, primary key
#  name              :string
#  version           :string
#  depot             :string
#  link              :string
#  duration          :integer
#  commencement_date :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# Base Roster, used to generate personal rosters
class BaseRoster < ActiveRecord::Base
  include TimeFormatter
  
  has_many :lines
  
  def total_hours
    total = 0
    lines.each do |line|
      total += line.duration
    end
    format_hhmm(total)
  end
end
