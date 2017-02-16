class AddDaysToTurns < ActiveRecord::Migration
  def change
    add_column :turns, :days, :string
  end
end
