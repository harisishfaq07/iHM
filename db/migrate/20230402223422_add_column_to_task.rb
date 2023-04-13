class AddColumnToTask < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks , :deadline 
    add_column :tasks , :dead_time , :datetime
    add_column :tasks , :dead_day , :datetime
  end
end
