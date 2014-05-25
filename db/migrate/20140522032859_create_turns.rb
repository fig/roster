class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.string :name
      t.time :time_on
      t.time :time_off
      t.time :duration
      t.string :hours
      t.string :start_time
      t.string :finish_time
      t.timestamps
    end
  end
end
