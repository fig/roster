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
    { '01': '1', '001': '1', '10': '10' }.each do |key, value|
      @line.number = key
      @line.valid?
      assert_equal value, @line.number, 'Validated line without stripping zero'
    end
  end

  test 'number should be numeric' do
    @line.number = 'fred'
    refute @line.valid?
  end

  test 'should return an array' do
    assert_equal([{ sun: "201" },
                  { mon: "01" },
                  { tue: "41" },
                  { wed: "RD" },
                  { thu: "RD" },
                  { fri: "A/R" },
                  { sat: "101" }],
                  @line.to_a)
  end

  test 'should calculate weekly hours' do
    line = create :line, sun: false,
                         mon: '1',
                         tue: '1',
                         wed: '1',
                         thu: '1',
                         fri: '1',
                         sat: false
    assert_equal('5.00', line.total_hours)
  end
end
