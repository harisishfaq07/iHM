class UpdateColToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :parent_id, :integer, :default => 0
  end
end
