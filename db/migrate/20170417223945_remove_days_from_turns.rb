class RemoveDaysFromTurns < ActiveRecord::Migration
  def change
    remove_column :turns, :days, :string
  end
end
