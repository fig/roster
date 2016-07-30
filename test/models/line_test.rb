require 'test_helper'

class LineTest < ActiveSupport::TestCase

  def setup
    @line = Line.new number: '01'
  end

  test "should not save line without number" do
    line = Line.new
    assert_not line.save, "Saved the line without a name"
  end


end
