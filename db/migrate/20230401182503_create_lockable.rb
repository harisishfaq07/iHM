class CreateLockable < ActiveRecord::Migration[7.0]
  def change
    create_table :lockables do |t|
      t.integer :user_id
      t.integer :status , :default => 0
      t.string :reason

      t.timestamps
    end
  end
end
