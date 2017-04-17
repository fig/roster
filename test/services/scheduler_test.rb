require 'test_helper'

class SchedulerTest < ActiveSupport::TestCase
  setup do
    @turn = create :turn
    @base_roster = create :base_roster
    @lines = create_list(:line, 10, base_roster: @base_roster)
   # @base_roster.lines[0].mon = '1'
    @user = create :user, base_roster: @base_roster
    @date = Date.new(2017, 01, 02)
  end
  
  # test 'should return Turn, given User and Date' do
  #   assert_equal @turn, Scheduler.which_turn(@user, @date)
  # end
  
  # test 'should return Turn, given User and Date, after going around the clock' do
  #   assert_equal @turn, Scheduler.which_turn(@user, Date.new(2017, 03, 13))
  # end
  
  # test 'should return User, given Turn and Date' do
  #   Timecop.freeze(Time.local(2017, 01, 02))
  #   assert_equal @user, Scheduler.which_driver(@turn, @date)
  # end
end
