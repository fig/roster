require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @base_roster = create :base_roster_with_lines
    @user = build :user, base_roster: @base_roster
  end
  
  test "should calculate current line" do
    Timecop.freeze(Date.new(2017, 01, 02))
    assert_equal 0, @user.current_line
  end
  
  test "should calculate current line after going around the clock" do
    Timecop.freeze(Date.new(2017, 04, 12))
    assert_equal 4, @user.current_line
  end
end
