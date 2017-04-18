require 'test_helper'

class SchedulerTest < ActiveSupport::TestCase
  setup do
    @turn = create :turn
    @base_roster = create :base_roster
    ('1'..'10').each do |i|
      create :line, number: i, base_roster: @base_roster
    end
    @user = create :user, base_roster: @base_roster
    @date = Date.new(2017, 1, 2)
  end
  
  test 'should return Turn, given User and Date' do
    assert_equal @turn, Scheduler.which_turn(@user, @date)
  end

  test 'should return Turn, given User and Date, after going around the clock' do
    assert_equal @turn, Scheduler.which_turn(@user, Date.new(2017, 03, 13))
  end

  test 'should return User, given Turn and Date' do
    assert_equal @user, Scheduler.which_driver(@turn, @date)
  end
end
