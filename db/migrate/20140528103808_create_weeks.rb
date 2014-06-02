class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :number

      t.timestamps
    end
    create_table :turns_weeks, id: false do |t|
      t.belongs_to :turn
      t.belongs_to :week
    end

  end
end
