class ChangeLimitForTimes < ActiveRecord::Migration
  def change
    change_column :turns, :time_on, :string, limit: 4
    change_column :turns, :time_off, :string, limit: 4
  end
end
