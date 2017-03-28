# == Schema Information
#
# Table name: turns
#
#  id          :integer          not null, primary key
#  name        :string
#  time_on     :string(4)        default("")
#  time_off    :string(4)        default("")
#  duration    :time
#  hours       :string
#  start_time  :time
#  finish_time :time
#  created_at  :datetime
#  updated_at  :datetime
#  start_date  :date
#  end_date    :date
#  sun         :boolean
#  mon         :boolean
#  tue         :boolean
#  wed         :boolean
#  thu         :boolean
#  fri         :boolean
#  sat         :boolean
#  days        :string
#

class Turn < ActiveRecord::Base
  require 'time'
  include ActiveModel::Validations
  include TimeFormatter
  
  has_many :days
  has_many :lines, through: :days

  DAY_CODES = {
    64 => 'Su',
    62 => 'SX',
    60 => 'FSX',
    2 => 'FO',
    1 => 'SO'
  }

  before_validation :upcase_name!
  validates :name, presence: true
  validates :time_on, presence: true, unless: :day_off?
  validates :time_off, presence: true, unless: :day_off?
  validate :one_turn_per_day, unless: :spare?
  before_save :remove_non_digits,
              :pad_with_zero,
              unless: :day_off?
  before_save :format_times
  before_save :rename_spare_turn, if: :spare?

  ##
  # Returns a string representing the operating days of +Turn+.
  #
  # M  - Monday
  # T  - Tuesday
  # W  - Wednesday
  # Th - Thursday
  # F  - Friday
  # S  - Saturday
  #
  # * Adding ‘O’ to the abbreviation for the day or days
  #   (eg WO) means the train runs only on the day or
  #   days preceding the ‘O’
  # * Adding ‘X’ to the abbreviation for the day or days
  #   (eg FX) means the train runs on all the days in this
  #   section of the Timetable except the day or days
  #   preceding the ‘X’
  # * Sunday (Su) is treated differently and a +Turn+ coded +SU+ will operate
  #   on Sundays only.
  #
  #  turn = Turn.new sun: false,
  #                  mon: true,
  #                  tue: true,
  #                  wed: true,
  #                  thu: true,
  #                  fri: true,
  #                  sat: false
  #
  #  turn.days_code # => 'SX'

  def days_code
    DAY_CODES[binarize_days]
  end
  
  def display_name
    spare? ? 'A/R' : name
  end

protected

  ##
  # Returns a decimal +Integer+ representing the 7-bit binary representation of
  # +Turn+ operating days. Return value is used by +#days_code+ to look-up code
  # from +DAY_CODES+.
  #  turn = Turn.new sun: false,
  #                  mon: true,
  #                  tue: true,
  #                  wed: true,
  #                  thu: true,
  #                  fri: true,
  #                  sat: false
  #
  #  turn.binarize_days # => 62
  #  # Decimal representation of '0111110'

  def binarize_days
    [sun, mon, tue, wed, thu, fri, sat].map { |d| d ? '1' : '0' }.join.to_i(2)
  end

private

  def one_turn_per_day
    dupes = Turn.where(name: name).where.not(id: id)
    dupes.each do |dupe|
      errors[:base] << 'This turn already exists for this day' if clash?(dupe)
    end
  end

  def clash?(other)
    binarize_days & other.binarize_days != 0
  end

  def remove_non_digits
    [time_on, time_off].each { |t| t.gsub!(/\D/, '') }
  end

  def upcase_name!
    name.upcase! if name
  end

  def pad_with_zero
    self.time_on = time_on.rjust(4, '0')
    self.time_off = time_off.rjust(4, '0')
    # [time_on, time_off].map! { |t| t.rjust(4, '0') }
    # [TODO] Consider using " sprintf '%04d' "
  end

  def day_off?
    %w(RD OFF EX).any? { |n| name.include? n } if name
  end

  def spare?
    name.match(/^S|A\/R/)
  end
  
  def rename_spare_turn
    self.name = "S#{time_on}#{time_off}"
  end

  def format_times
    if day_off?
      self.time_on = self.time_off = nil
    else
      self.duration = diff(timify(time_on), timify(time_off))
      self.hours = format_hhmm(duration)
    end
  end

  def diff(on, off)
    off += 1.day if off < on
    off - on
  end
  
  def timify(str)
    Time.strptime(str, '%H%M')
  end
end
