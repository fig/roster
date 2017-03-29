# == Schema Information
#
# Table name: days
#
#  id         :integer          not null, primary key
#  name       :string
#  line_id    :integer
#  turn_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_days_on_line_id  (line_id)
#  index_days_on_turn_id  (turn_id)
#

class Day < ActiveRecord::Base
  belongs_to :line
  belongs_to :turn

  def sunday?
    name == 'sun'
  end
end
