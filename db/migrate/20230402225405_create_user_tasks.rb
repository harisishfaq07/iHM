class CreateUserTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tasks do |t|
        t.integer :user_id
        t.integer :task_id
        t.integer :has_parent , :default => 0
      t.timestamps
    end
  end
end
