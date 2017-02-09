class Turn < ActiveRecord::Base

  require 'time'

  before_validation :remove_non_digits,
                    :pad_with_zero,
                    unless: :day_off?

  validates :name, presence: true
  validates :time_on, :time_off,
            format: { with: /([01]\d|2[0-3])([0-5]\d)/ },
            unless: :day_off?

  before_save :format_times

  private

  def remove_non_digits
    [time_on, time_off].each { |t| t.gsub!(/\D/, '') }
  end

  def pad_with_zero
    self.time_on = time_on.rjust(4, '0') if time_on.size == 3
    self.time_off = time_off.rjust(4, '0') if time_off.size == 3
  end

  def day_off?
    name.upcase!
    name == 'RD' || name == 'OFF' || name.include?('EX')
  end

  def format_times
    if day_off?
      self.time_on = self.time_off = nil
      return true
    end
    # self.start_time = timify(time_on)
    # self.finish_time = timify(time_off)
    self.duration = diff(timify(time_on), timify(time_off))
    self.hours = duration_in_words(duration)
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

  def timify(str)
    Time.strptime(str, '%H%M')
  end
end
