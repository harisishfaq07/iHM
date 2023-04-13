class AddColumn < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :integer, :default => 0
  end
end
