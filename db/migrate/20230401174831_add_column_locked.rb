class AddColumnLocked < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :locked, :integer , :default => 0
  end
end
