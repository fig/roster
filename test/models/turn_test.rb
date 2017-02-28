require 'test_helper'

class TurnTest < ActiveSupport::TestCase
  def setup
    @turn = FactoryGirl.build :turn
  end

  test 'running turn is valid' do
    assert @turn.valid?, 'Valid turn failed validation'
  end

  test 'spare turn is valid' do
    @turn.name = 'a/r'
    assert @turn.valid?, 'Spare turn failed validation'
  end

  test 'day off is valid' do
    @turn.time_on, @turn.time_off = ''
    %w(off rd ex1).each do |name|
      @turn.name = name
      assert @turn.valid?, 'Day off failed validation'
      @turn.save
      assert @turn.time_on.nil?, 'Failed to strip time_on from day off'
      assert @turn.time_off.nil?, 'Failed to strip time_off from day off'
    end
  end

  test 'invalid without name' do
    @turn.name = ''
    refute @turn.valid?, 'Turn is valid without a name'
  end

  test 'running turn invalid without times' do
    @turn.time_on = ''
    @turn.time_off = nil
    refute @turn.valid?, 'Turn is not a day off but is valid without times'
  end

  test 'should pad with leading zero' do
    @turn.time_on = '100'
    @turn.save
    assert_equal '0100', @turn.time_on, 'Failed to pad times'
  end

  test 'should strip non-digits from times' do
    ['09:00', '9 00', '9.00am'].each do |time|
      @turn.time_on = time
      @turn.save
      assert_equal '0900', @turn.time_on, 'Failed to strip non-digits'
    end
  end

  test 'turn duration should be correct and formatted' do
    @turn.save
    assert_equal 3600, @turn.duration, 'Duration calculated incorrectly'
    assert_equal '1:00', @turn.hours, 'Hours formatted incorrectly'
  end

  test 'create SX days' do
    assert_equal 'SX', @turn.days_code, 'SX not created'
  end

  test 'create FSX days' do
    @turn.fri = false
    assert_equal 'FSX', @turn.days_code, 'FSX not created'
  end

  test 'uniqueness of name unless on different days' do
    @turn.save
    another_turn = create :turn, name: '1',
                             time_off: '1200',
                              time_on: '0900',
                                  mon: false,
                                  tue: false,
                                  wed: false,
                                  thu: false,
                                  fri: false,
                                  sun: true
    assert another_turn.valid? "Didn't allow same turn on different day"
    another_turn.mon = true
    refute another_turn.valid?, 'Allowed duplicate Turn on same day'
  end

  test 'allow multiple Spare Turns' do
    create :turn, name: 'A/R',
                   mon: true
    another_turn = build :turn, name: 'A/R',
                                 mon: true
    assert another_turn.valid?, "Didn't allow duplicate Spare turn"
  end
end
