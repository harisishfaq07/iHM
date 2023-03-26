class CreatePackages < ActiveRecord::Migration[7.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.integer :contacts_allowed
      t.integer :price 
      t.integer :status , :default => 1

      t.timestamps
    end
  end
end
