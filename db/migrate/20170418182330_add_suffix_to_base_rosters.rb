class AddSuffixToBaseRosters < ActiveRecord::Migration
  def change
    add_column :base_rosters, :suffix, :string
  end
end
