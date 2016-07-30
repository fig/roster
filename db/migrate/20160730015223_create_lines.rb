class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
