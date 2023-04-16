class AddColumnToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :assigned_by, :string
  end
end
