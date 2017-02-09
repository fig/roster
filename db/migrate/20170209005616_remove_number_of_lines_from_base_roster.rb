class RemoveNumberOfLinesFromBaseRoster < ActiveRecord::Migration
  def change
    remove_column :base_rosters, :number_of_lines, :string
  end
end
