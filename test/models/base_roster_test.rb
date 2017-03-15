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

require 'test_helper'

class BaseRosterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
