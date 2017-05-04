require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @base_roster = create :base_roster
    # ('1'..'10').each do |i|
    #   create :line, number: i, base_roster: @base_roster
    # end
    @user = build :user, base_roster: @base_roster
  end

  test "should calculate current line" do
    create :line, base_roster: @base_roster
    Timecop.freeze(Date.new(2017, 01, 02))
    assert_equal 0, @user.current_line
  end

  test "should calculate current line after going around the clock" do
    (1..3).each do |i|
      create :line, number: i, base_roster: @base_roster
    end
    Timecop.freeze(Date.new(2017, 04, 12))
    assert_equal 2, @user.current_line
  end

  test 'should know full name' do
    assert_equal 'Firstname Lastname', @user.name
  end

  test 'should know short_name' do
    assert_equal 'F Lastname', @user.short_name
  end
end
