class Turn < ActiveRecord::Base
  require 'time'
  include ActiveModel::Validations

  before_validation :remove_non_digits,
                    :upcase!,
                    :pad_with_zero,
                    unless: :day_off?

  validates :name, presence: true
  validates :time_on, :time_off,
            format: { with: /([01]\d|2[0-3])([0-5]\d)/ },
            unless: :day_off?
  before_save :format_times
  validate :one_turn_per_day, unless: :spare?

  def one_turn_per_day
    dupes = Turn.where(name: name)
    dupes.each do |dupe|
      next if dupe.id == id
      errors[:base] << "This turn already exists for this day" if clash?(dupe)
    end
  end

  def days_code
    opts = {
      64 => 'Su',
      62 => 'SX',
      60 => 'FSX',
      2 => 'FO',
      1 => 'SO'
    }
    opts[binarize_days]
  end

  def binarize_days
    [sun, mon, tue, wed, thu, fri, sat].map { |d| d ? '1' : '0' }.join.to_i(2)
  end

  def clash?(other)
    binarize_days & other.binarize_days != 0
  end

  private

  def remove_non_digits
    [time_on, time_off].each { |t| t.gsub!(/\D/, '') }
  end

  def upcase!
    name.upcase!
  end

  def pad_with_zero
    self.time_on = time_on.rjust(4, '0')
    self.time_off = time_off.rjust(4, '0')
    #[time_on, time_off].map! { |t| t.rjust(4, '0') }
  end

  def day_off?
    %w(RD OFF EX).any? { |n| name.include? n }
  end

  def spare?
    name == 'A/R'
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
