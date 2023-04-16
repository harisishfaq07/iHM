class ChangeColName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users , :partner , :alpha
    rename_column :family_members , :partner , :alpha

  end
end
