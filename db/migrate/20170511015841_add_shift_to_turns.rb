class AddShiftToTurns < ActiveRecord::Migration
  def change
    add_column :turns, :shift, :string
  end
end
