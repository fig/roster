class AddPreferenceToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :preference, :string
  end
end
