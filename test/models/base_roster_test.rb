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
  def setup
    @base_roster = create :base_roster
  end

  test "block hours" do
    create :turn, base_roster: @base_roster
    create :turn, name: '101',
                  sun: true,
                  base_roster: @base_roster
    @line = create :line, sun: '101',
                          mon: '1',
                          tue: '1',
                          base_roster: @base_roster
    assert_equal '2:00', @base_roster.total_hours
  end
end