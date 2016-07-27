require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  
  def setup
    @turn = Turn.new name: "01", time_on: "1200", time_off: "1300"
  end

  test "should strip non-digits from times" do
    @turn.time_on = "09:00"
    @turn.validate
    assert_equal "0900", @turn.time_on
  end

  test "should be valid" do
    assert @turn.valid?
  end

  test "name should be present" do
    @turn.name = ""
    assert_not @turn.valid?
  end

  test "times should be valid" do
    [@turn.time_on, @turn.time_off].each do |t|
      assert_match /([01]\d|2[0-3])([0-5]\d)/, t
    end
  end

  test "days off don't need times" do
    @turn.time_on = @turn.time_off = ""
    ["RD", "off", "EX1"].each do |name|
      @turn.name = name
      assert @turn.valid?
    end
  end

  test "turn duration should correct and formatted" do
    @turn.save
    assert_equal 3600, @turn.duration
    assert_equal "1:00", @turn.hours
  end

end
