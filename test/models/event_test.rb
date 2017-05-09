require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @date = Date.new 2017, 1, 2
    @turn = create :turn
  end

  test 'should create Event' do
    event = Event.new(@date, @turn)
    assert_equal Event, event.class
    assert_equal '2017-01-02 05:00:00 +0000' , event.start_time.inspect
    assert_equal 'VG1', event.summary
  end
end