class AddLinesCountToBaseRosters < ActiveRecord::Migration
  def change
    change_table :base_rosters do |t|
      t.integer :lines_count, default: 0
    end

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE base_rosters
           SET lines_count = (SELECT count(1)
                                   FROM lines
                                  WHERE lines.base_roster_id = base_rosters.id)
    SQL
  end
end
