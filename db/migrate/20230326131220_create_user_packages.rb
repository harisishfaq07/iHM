class CreateUserPackages < ActiveRecord::Migration[7.0]
  def change
    create_table :user_packages do |t|
      t.integer :user_id
      t.integer :package_id
      t.integer :status , :default => 1

      t.timestamps
    end
  end
end
