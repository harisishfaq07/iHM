class CreateTasks < ActiveRecord::Migration[7.0]
  require 'date'
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.string :task_desc
      t.datetime :deadline 
      t.integer :status , :default => 1
      t.boolean :archieved , :default => false
      t.integer :user_id 
      t.integer :member_id
      t.string :assign_to 

      t.timestamps
    end
  end
end
