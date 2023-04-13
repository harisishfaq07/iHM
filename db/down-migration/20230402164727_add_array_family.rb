class AddArrayFamily < ActiveRecord::Migration[7.0]
  def change
    add_column :families, :user_id, :integer, :default => []
  end
end
