class AddDaysToLines < ActiveRecord::Migration
  change_table :lines do |t|
    t.string :sun
    t.string :mon
    t.string :tue
    t.string :wed
    t.string :thu
    t.string :fri
    t.string :sat
  end
end
