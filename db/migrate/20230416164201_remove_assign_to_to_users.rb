class RemoveAssignToToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks , :assign_to
  end
end
