class ChangeLineDefaults < ActiveRecord::Migration
  def up
    change_table :lines do |t|
      t.change :sun, :string, default: 'OFF'
      t.change :mon, :string, default: 'RD'
      t.change :tue, :string, default: 'RD'
      t.change :wed, :string, default: 'RD'
      t.change :thu, :string, default: 'RD'
      t.change :fri, :string, default: 'RD'
      t.change :sat, :string, default: 'RD'
    end
  end

  def down
    change_table :lines do |t|
      t.change :sun, :string, default: nil
      t.change :mon, :string, default: nil
      t.change :tue, :string, default: nil
      t.change :wed, :string, default: nil
      t.change :thu, :string, default: nil
      t.change :fri, :string, default: nil
      t.change :sat, :string, default: nil
    end
  end
end
