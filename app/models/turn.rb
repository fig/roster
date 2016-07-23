class Turn < ActiveRecord::Base

  require 'time'

  has_and_belongs_to_many :Weeks

  validates :name, presence: true
  validates :time_on, :time_off, format: { with: /([01]\d|2[0-3])([0-5]\d)/}, 
                                 presence: true, unless: :day_off?
  
  #### TODO - validate time_on & time_off as valid times
  #### probably with 'validates_format_of'

  before_save :format_times

  private

  def day_off?
    self.name.upcase!
    self.name == 'RD' or self.name == 'OFF' or self.name.include?('EX')
  end

  def format_times
    if day_off?
      self.time_on = self.time_off = nil
      return true
    end

    self.start_time = timify(time_on)
    self.finish_time = timify(time_off)
    self.duration = diff(start_time, finish_time)
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
