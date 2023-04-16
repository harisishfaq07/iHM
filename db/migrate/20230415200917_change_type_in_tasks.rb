class ChangeTypeInTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks , :task_type , :integer
  end
end
