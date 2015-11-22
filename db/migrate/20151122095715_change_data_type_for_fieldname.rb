class ChangeDataTypeForFieldname < ActiveRecord::Migration
  def self.up
    change_table :turns do |t|
      t.change :start_time, :time
      t.change :finish_time, :time
    end
  end
  def self.down
    change_table :turns do |t|
      t.change :start_time, :string
      t.change :finish_time, :string
    end
  end
end
