class AddColumnFamilyUseridArray < ActiveRecord::Migration[7.0]
  def change
    drop_column :family , :user_id
    add_column :family, :user_ids, array: true, default: []
  end
end
