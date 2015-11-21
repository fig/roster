class Turn < ActiveRecord::Base

  require 'time'

  has_and_belongs_to_many :Weeks

  validates :name, presence: true
  validates :time_on, :time_off, presence: true, unless: :day_off?

  before_save :format_times

  private

  def day_off?
    self.name.upcase!
    self.name == 'RD' or self.name == 'OFF' or self.name.include?( 'EX' )
  end

  def format_times
    if day_off?
      self.time_on = self.time_off = nil
      return true
    end
    # self.time_on = insert_colon(time_on)
    # self.time_off = insert_colon(time_off)
    self.duration = diff(time_on, time_off)
    self.hours = duration_in_words(duration)
    self.start_time = time_on#.strftime('%H:%M')
    self.finish_time = time_off#.strftime('%H:%M')
  end

  def diff(on, off)
    on = Time.strptime( on, "%H%M" )
    off = Time.strptime( off, "%H%M" )
    off += 1.day if off < on
    off - on
  end

  def duration_in_words(duration)
    hh, ss = duration.divmod(3600)
    mm = ss / 60
    format('%d:%02d', hh, mm)
  end

  # def insert_colon(time_string)
  #   time_array = time_string.split''
  #   time_array.insert( -3, ":")
  #   time_string = time_array.join
  #   time=Time.parse(time_string)
  # end

end
