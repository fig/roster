class Line < ActiveRecord::Base
  belongs_to :base_roster

  before_validation :strip_leading_zeros

  validates :number, presence: true
  validates_uniqueness_of :number, scope: :base_roster

  private

  def strip_leading_zeros
    number.sub!(/^0+/, '')
  end
end
