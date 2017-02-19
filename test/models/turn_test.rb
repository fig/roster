require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  def setup
    @turn = FactoryGirl.build :turn
  end

  test 'valid turn' do
    turn = Turn.new(name: '1')
    assert turn.valid? 'Valid turn failed validation'
  end

  test 'invalid without name' do
    turn = Turn.new
    refute turn.valid?, 'turn is valid without a name'
    assert_not_nil turn.errors[:name], 'no validation error for name present'
  end

##########################################################

  test 'should pad with leading zero' do
    @turn.time_on = '100'
    @turn.save
    assert_equal '0100', @turn.time_on
  end

  test 'should strip non-digits from times' do
    ['09:00', '9 00', '9.00am'].each do |time|
      @turn.time_on = time
      @turn.save
      assert_equal '0900', @turn.time_on
    end
  end

  test 'name should be present' do
    @turn.name = ''
    assert_not @turn.valid?
  end

  test 'times should be valid' do
    [@turn.time_on, @turn.time_off].each do |t|
      assert_match(/([01]\d|2[0-3])([0-5]\d)/, t)
    end
  end

  test "days off don't need times" do
    %w(RD off EX1).each do |name|
      turn = build :turn, name: name, time_on: '', time_off: ''
      assert turn.valid?
    end
  end

  test 'turn duration should be correct and formatted' do
    @turn.save
    assert_equal 3600, @turn.duration
    assert_equal '1:00', @turn.hours
  end

  test 'create SX days' do
    assert_equal 'SX', @turn.days_code
  end

  test 'create FSX days' do
    @turn.fri = false
    assert_equal 'FSX', @turn.days_code
  end

  test 'turns not clashing' do
    turn1 = Turn.new name: '1', mon: true
    turn2 = Turn.create name: '1', sun: true
    assert turn2.valid? 'Valid turn failed validation'
  end

  test 'uniqueness of name unless on different days' do
    @turn.save
    turn = Turn.new name: '1',
                    time_on: '0900',
                    time_off: '1200',
                    mon: true
    assert_not turn.valid?, 'Allowed duplicate Turn on same day'
    turn = Turn.new name: '1',
                    time_on: '0900',
                    time_off: '1200',
                    sun: true
    assert turn.valid?, "Didn't allow same turn on different day"
  end

  test 'allow multiple Spare Turns' do
    create :turn, name: 'A/R',
                  mon: true
    turn = build :turn,
                 name: 'A/R',
                 mon: true
    assert turn.valid?, "Didn't allow duplicate Spare turn"
  end
end
