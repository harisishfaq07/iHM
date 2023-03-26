class AddColToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gender, :string
    add_column :users, :parent_id, :integer
    add_column :users, :country, :string
    add_column :users, :dateofbirth , :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
