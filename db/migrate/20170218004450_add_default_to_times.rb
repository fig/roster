class AddDefaultToTimes < ActiveRecord::Migration
  def change
    change_column_default :turns, :time_on, from: nil, to: ''
    change_column_default :turns, :time_off, from: nil, to: ''
  end
end
