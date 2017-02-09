class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.string :name
      t.belongs_to :line, index: true
      t.belongs_to :turn, index: true

      t.timestamps null: false
    end
  end
end
