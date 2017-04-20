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
#  lines_count       :integer          default(0)
#  suffix            :string
#

# Base Roster, used to generate personal rosters
class BaseRoster < ActiveRecord::Base
  include TimeFormatter

  has_many :users
  has_many :lines
  has_many :turns

  def total_hours
    total_duration = lines.map {|line| line.duration}.inject(0, :+)
    format_hhmm(total_duration)
  end
end
