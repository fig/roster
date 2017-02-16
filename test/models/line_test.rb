require 'test_helper'

class LineTest < ActiveSupport::TestCase
  def setup
    @line = build :line
  end

  test 'should not save line without number' do
    @line.number = ''
    assert_not @line.save, 'Saved the line without a number'
  end

  test 'format line number' do
    @line.number = '01'
    @line.save
    assert_equal '1', @line.number, 'Saved line without formatting number'
  end

  # test 'should not save duplicate line number' do
  #   @line.save
  #   line2 = build :line
  #   assert_not line2.valid?
  # end
end
