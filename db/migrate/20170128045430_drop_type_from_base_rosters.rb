class DropTypeFromBaseRosters < ActiveRecord::Migration
  def change
    remove_column :base_rosters, :type, :string
  end
end
