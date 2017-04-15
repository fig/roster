class AddBaseRosterRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :base_roster, index: true, foreign_key: true
  end
end
