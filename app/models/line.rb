class Line < ActiveRecord::Base
  belongs_to :base_roster

  validates :number, presence: true

  before_save :strip_leading_zeros

  private

  def strip_leading_zeros
    number.sub!(/^0+/,"")
  end
end
