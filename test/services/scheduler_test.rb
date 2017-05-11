require 'test_helper'

class SchedulerTest < ActiveSupport::TestCase
  setup do
    @turn = create :turn
    # @base_roster = create :base_roster
    (1..3).each do |i|
      create :line, number: i, base_roster_id: 1
    end
    @user = create :user, base_roster_id: 1
    @date = Date.new(2017, 1, 2)
  end

  test 'should return Turn, given User and Date' do
    assert_equal @turn, Scheduler.new(user: @user, date: @date).which_turn
  end

  test 'should return Turn, given User and Date, after going around the clock' do
    assert_equal @turn, Scheduler.new(user: @user, date: Date.new(2017, 03, 13)).which_turn
  end

  test 'should return User, given Turn and Date' do
    assert_equal @user, Scheduler.new(turn: @turn, date: @date).which_driver
  end
end
