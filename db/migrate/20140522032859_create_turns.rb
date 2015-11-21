class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.string :name
      t.string :time_on
      t.string :time_off
      t.time :duration
      t.string :hours
      t.string :start_time
      t.string :finish_time
      t.timestamps
    end
  end
end
