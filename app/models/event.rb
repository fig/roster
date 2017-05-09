class Event
  attr_reader :turn

  def initialize(date, turn)
    @date = date
    @turn = turn
  end

  def start_time
    @date.to_time + @turn.start_time.seconds_since_midnight
  end

  def summary
    @turn.name_for :display
  end
end