class Turn < ActiveRecord::Base
  validates :name, :time_on, :time_off, presence: true

  before_save :format_times

  private

  def format_times
    self.duration = diff(time_on, time_off)
    self.hours = duration_in_words(duration)
    self.start_time = time_on.strftime('%H:%M')
    self.finish_time = time_off.strftime('%H:%M')
  end

  def diff(on, off)
    off += 1.day if off < on
    off - on
  end

  def duration_in_words(duration)
    hh, ss = duration.divmod(3600)
    mm = ss / 60
    format('%d:%02d', hh, mm)
  end
end
