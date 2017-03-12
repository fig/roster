class Line < ActiveRecord::Base
  belongs_to :base_roster

  before_validation :strip_leading_zeros, :upcase!

  validates :number, presence: true, numericality: true
  validates_uniqueness_of :number, scope: :base_roster

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
    number.sub!(/^0+/, '')
  end

  def upcase!
    [sun, mon, tue, wed, thu, fri, sat].each do |day|
      day.upcase! if day
    end
  end
end
