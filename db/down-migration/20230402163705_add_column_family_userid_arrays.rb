class AddColumnFamilyUseridArrays < ActiveRecord::Migration[7.0]
  def change
    add_column :family, :members_id, :string, array: true
  end
end
