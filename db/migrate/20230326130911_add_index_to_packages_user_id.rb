class AddIndexToPackagesUserId < ActiveRecord::Migration[7.0]
  def change
    add_column :packages, :user_id, :integer
    add_index :packages , :user_id
  end
end
