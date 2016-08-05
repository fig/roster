class AddBaseRosterRefToLines < ActiveRecord::Migration
  def change
    add_reference :lines, :base_roster, index: true, foreign_key: true
  end
end
