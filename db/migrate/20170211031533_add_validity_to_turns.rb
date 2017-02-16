class AddValidityToTurns < ActiveRecord::Migration
  def change
    add_column :turns, :start_date, :date
    add_column :turns, :end_date, :date
    add_column :turns, :sun, :boolean
    add_column :turns, :mon, :boolean
    add_column :turns, :tue, :boolean
    add_column :turns, :wed, :boolean
    add_column :turns, :thu, :boolean
    add_column :turns, :fri, :boolean
    add_column :turns, :sat, :boolean
    add_column :turns, :validity, :string
  end
end
