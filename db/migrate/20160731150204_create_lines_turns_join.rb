class CreateLinesTurnsJoin < ActiveRecord::Migration
  def change
    create_table :lines_turns, id: false do |t|
      t.integer 'line_id'
      t.integer 'turn_id'
    end
    add_index :lines_turns, ['line_id', 'turn_id']
  end
end
