# == Schema Information
#
# Table name: lines
#
#  id             :integer          not null, primary key
#  number         :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  base_roster_id :integer
#  sun            :string
#  mon            :string
#  tue            :string
#  wed            :string
#  thu            :string
#  fri            :string
#  sat            :string
#

class Line < ActiveRecord::Base
  include TimeFormatter
  
  belongs_to :base_roster
  has_many :days
  has_many :turns, through: :days

  before_validation :strip_leading_zeros, :upcase!
  after_save :associate_turns

  validates :number, presence: true, numericality: true
  validates_uniqueness_of :number, scope: :base_roster

  def total_hours
    format_hhmm(duration)
  end
  
  def duration
    weekdays.map {|day| day.duration}.inject(0, :+)
  end
  
  def to_a
    [
      { sun: sun.to_s },
      { mon: mon.to_s },
      { tue: tue.to_s },
      { wed: wed.to_s },
      { thu: thu.to_s },
      { fri: fri.to_s },
      { sat: sat.to_s }
    ]
  end

  private

  def strip_leading_zeros
    number.sub!(/^0+/, '') if number
  end

  def upcase!
    [sun, mon, tue, wed, thu, fri, sat].each do |day|
      day.upcase! if day
    end
  end
  
  def associate_turns
    self.days.delete_all
    self.to_a.each do |day|
      self.days.create name: day.keys.first, turn: Turn.find_by(name: day.values.first, day.keys.first => true)
    end
  end
  
  def weekdays
    turns.select {|turn| turn.sun == false}
  end
end
