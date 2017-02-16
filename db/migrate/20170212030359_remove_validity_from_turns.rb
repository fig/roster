class RemoveValidityFromTurns < ActiveRecord::Migration
  def change
    remove_column :turns, :validity, :string
  end
end
