class AddColumnFamilyUserid < ActiveRecord::Migration[7.0]
  def change
    add_column :family, :user_id, :string, array: true
  end
end
