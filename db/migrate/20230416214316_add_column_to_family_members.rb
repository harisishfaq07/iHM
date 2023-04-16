class AddColumnToFamilyMembers < ActiveRecord::Migration[7.0]
  def change
    add_column :family_members, :partner, :integer , :default => 0
  end
end
