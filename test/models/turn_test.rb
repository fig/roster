# == Schema Information
#
# Table name: turns
#
#  id          :integer          not null, primary key
#  name        :string
#  time_on     :string(4)        default("")
#  time_off    :string(4)        default("")
#  duration    :time
#  hours       :string
#  start_time  :time
#  finish_time :time
#  created_at  :datetime
#  updated_at  :datetime
#  start_date  :date
#  end_date    :date
#  sun         :boolean
#  mon         :boolean
#  tue         :boolean
#  wed         :boolean
#  thu         :boolean
#  fri         :boolean
#  sat         :boolean
#  days        :string
#

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
                                sun: true,
                                base_roster_id: 1
    assert another_turn.valid? "Didn't allow same turn on different day"
    another_turn.mon = true
    refute another_turn.valid?, 'Allowed duplicate Turn on same day'
  end

  test 'spare turn should rename itself' do
    spare_turn = create :turn, name: 's', time_on: '0700', time_off: '1500'
    assert_equal 'S07001500', spare_turn.name
    assert_equal 'A/R', spare_turn.name_for(:display)
    assert_equal 'A/R', spare_turn.name_for(:roster)
  end

  test 'running turn shoud rename itself' do
    turn = create :turn
    assert_equal 'VG1', turn.name_for(:display, 'VG')
    assert_equal '0001', turn.name_for(:roster)
  end

  test 'Sunday off shoud rename itself' do
    turn = create :turn, name: 'OFF', sun: true
    assert_equal 'OFF', turn.name_for(:display)
    assert_equal '', turn.name_for(:roster)
  end

  test 'Rest Day shoud rename itself' do
    turn = create :turn, name: 'RD'
    assert_equal 'RD', turn.name_for(:display)
    assert_equal 'RD', turn.name_for(:roster)
  end

  test 'allow multiple Spare Turns' do
    create :turn, name: 'S', mon: true
    another_turn = build :turn, name: 'S', mon: true
    assert another_turn.valid?, "Didn't allow duplicate Spare turn"
  end

  test 'start_time' do
    time = Timecop.freeze(Time.local(1990, 1, 1, 5))
    turn = build :turn
    assert_equal time, turn.start_time
  end
end
