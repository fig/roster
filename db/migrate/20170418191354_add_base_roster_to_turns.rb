class AddBaseRosterToTurns < ActiveRecord::Migration
  def change
    add_reference :turns, :base_roster, index: true, foreign_key: true
  end
end
