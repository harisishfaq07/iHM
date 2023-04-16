class ChangeColumnToTasks < ActiveRecord::Migration[7.0]
  def change
    change_column :tasks , :dead_time , :string
    change_column :tasks , :dead_day , :string
  end
end
