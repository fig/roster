# == Schema Information
#
# Table name: lines
#
#  id             :integer          not null, primary key
#  number         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  base_roster_id :integer
#  sun            :string
#  mon            :string
#  tue            :string
#  wed            :string
#  thu            :string
#  fri            :string
#  sat            :string
#

require 'test_helper'

class LineTest < ActiveSupport::TestCase
  def setup
    @line = build :line
  end

  test 'should be valid' do
    assert @line.valid?
  end

  test 'should not be valid without number' do
    @line.number = ''
    refute @line.valid?, 'line validated without number'
  end

  test 'number should be unique to base_roster' do
    @line.base_roster_id = 1
    @line.save
    another_line = build :line, number: @line.number, base_roster_id: 1
    refute another_line.valid?,
    "Allowed duplicate number #{@line.number} && #{another_line.number}"
    another_line.base_roster_id = 2
    assert another_line.valid?,
    "Didn't allow duplicate number in different rosters"
  end

  test 'number should be numeric' do
    @line.number = 'fred'
    refute @line.valid?
  end

  test 'should create association with turns' do
    @line = create :line
    assert_equal 7, @line.days.count
  end

  test 'should calculate duration and weekly hours' do
    create :turn
    create :turn, name: '101', sun: true, duration: 3600
    @line = create :line, sun: '101',
                        mon: '1',
                        tue: '1',
                        wed: '1',
                        thu: '1',
                        fri: '1',
                        sat: ''
   assert_equal 18000, @line.duration
   assert_equal '5:00', @line.total_hours
  end
end
