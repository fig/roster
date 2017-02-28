require 'test_helper'

class LineTest < ActiveSupport::TestCase
  def setup
    @line = build :line
  end

  test 'should be valid' do
    assert @line.valid?
  end

  test 'should not be valid without number' do
    @line.number = ''
    refute @line.valid?, 'line validated without number'
  end

  test 'number should be unique to base_roster' do
    @line.base_roster_id = 1
    @line.save
    another_line = build :line, base_roster_id: 1
    refute another_line.valid?, 'Allowed duplicate name'
    another_line.base_roster_id = 2
    assert another_line.valid?, "Didn't allow duplicate number in
                                 different rosters"
  end

  test 'should strip leading zero before validation' do
    %w(01 001).each do |number|
      @line.number = number
      @line.valid?
      assert_equal '1', @line.number, 'Validated line without stripping zero'
    end
  end

  # test 'should not save duplicate line number' do
  #   @line.save
  #   line2 = build :line
  #   assert_not line2.valid?
  # end
end
