class CreateBaseRosters < ActiveRecord::Migration
  def change
    create_table :base_rosters do |t|
      t.string :name
      t.string :version
      t.string :depot
      t.string :link
      t.integer :duration
      t.string :type
      t.date :commencement_date
      t.integer :number_of_lines

      t.timestamps null: false
    end
  end
end
