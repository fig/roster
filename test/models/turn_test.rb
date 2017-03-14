require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  test 'running turn is valid' do
    turn = build :turn
    assert turn.valid?, 'Valid turn failed validation'
    assert_equal '1', turn.name
    assert_equal '0500', turn.time_on
    assert turn.mon
  end

  test 'day off is valid' do
    turn = build :turn, time_on: '', time_off: ''
    %w(off rd ex1).each do |name|
      turn.name = name
      assert turn.valid?, 'Day off failed validation'
      turn.save
      assert turn.time_on.nil?, 'Failed to strip time_on from day off'
      assert turn.time_off.nil?, 'Failed to strip time_off from day off'
    end
  end

  test 'invalid without name' do
    turn = build :turn, name: ''
    refute turn.valid?, 'Turn is valid without a name'
  end

  test 'running turn invalid without times' do
    turn = build :turn, time_on: '', time_off: nil
    refute turn.valid?, 'Turn is not a day off but is valid without times'
  end

  test 'should pad with leading zero' do
    turn = create :turn, time_on: '100'
    assert_equal '0100', turn.time_on, 'Failed to pad times'
  end

  test 'should strip non-digits from times' do
    ['09:00', '9 00', '9.00am'].each_with_index do |time, name|
      turn = create :turn, name: name, time_on: time
      assert_equal '0900', turn.time_on, 'Failed to strip non-digits'
    end
  end

  test 'turn duration should be correct and formatted' do
    turn = create :turn
    assert_equal 3600, turn.duration, 'Duration calculated incorrectly'
    assert_equal '1:00', turn.hours, 'Hours formatted incorrectly'
  end

  test 'days code' do
    turn = build :turn
    assert_equal 'SX', turn.days_code, 'SX not created'
  end

  test 'uniqueness of name unless on different days' do
    create :turn
    another_turn = build :turn, mon: false,
                                tue: false,
                                wed: false,
                                thu: false,
                                fri: false,
                                sun: true
    assert another_turn.valid? "Didn't allow same turn on different day"
    another_turn.mon = true
    refute another_turn.valid?, 'Allowed duplicate Turn on same day'
  end
  
  test 'spare turn should rename itself' do
    spare_turn = create :turn, name: 's', time_on: '0700', time_off: '1500'
    assert_equal 'S07001500', spare_turn.name
    assert_equal 'A/R', spare_turn.display_name
  end
  
  test 'running turn shoud not rename' do
    turn = create :turn
    assert_equal '1', turn.display_name
  end

  test 'allow multiple Spare Turns' do
    create :turn, name: 'S', mon: true
    another_turn = build :turn, name: 'S', mon: true
    assert another_turn.valid?, "Didn't allow duplicate Spare turn"
  end
end
