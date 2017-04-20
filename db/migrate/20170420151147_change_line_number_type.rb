class ChangeLineNumberType < ActiveRecord::Migration
   def self.up
    change_column :lines, :number, :integer
  end

  def self.down
    change_column :lines, :number, :string
  end
end
