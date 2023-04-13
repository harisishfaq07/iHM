class AddColumnFamilyUseridArraysOkl < ActiveRecord::Migration[7.0]
  def change
    # rename_table :family, :families
    remove_column :families , :user_id
    remove_column :families , :members_id
  end
end
