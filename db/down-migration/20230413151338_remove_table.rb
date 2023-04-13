class RemoveTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :family_members 
    drop_table :families
  end
end
