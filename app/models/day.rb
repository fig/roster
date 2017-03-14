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

class Day < ActiveRecord::Base
  belongs_to :turn
end
