require 'test_helper'

class LineTest < ActiveSupport::TestCase
  def setup
    @line = Line.new number: '01', base_roster_id: 1
  end

  test 'should not save line without number' do
    @line = Line.new
    assert_not @line.save, 'Saved the line without a number'
  end

  test 'format line number' do
    @line.save
    assert_equal '1', @line.number, 'Saved line without formatting number'
  end


  # test 'should not save duplicate line number' do
  #   @line.save
  #   assert Line.count == 3
  # end
end
