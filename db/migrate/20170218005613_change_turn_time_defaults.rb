class ChangeTurnTimeDefaults < ActiveRecord::Migration
  def change
    change_column_default :turns, :time_on, ''
    change_column_default :turns, :time_off, ''
  end
end
