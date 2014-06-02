class Turn < ActiveRecord::Base

  has_and_belongs_to_many :Weeks

  validates :name, presence: true
  validates :time_on, :time_off, presence: true, unless: :day_off?

  before_save :format_times

  private

  def day_off?
    self.name == 'RD' or self.name == 'OFF'

  end

  def format_times
    if day_off?
      self.time_on = self.time_off = nil
      return true
    end
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
