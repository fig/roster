class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name_first, default: ''
      t.string :name_last, default: ''
      t.date :roster_epoch
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
