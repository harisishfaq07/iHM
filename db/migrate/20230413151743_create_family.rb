class CreateFamily < ActiveRecord::Migration[7.0]
  def change
    create_table :families do |t|
      t.string "family_name"
      t.string "no_of_members"
      t.integer "status", default: 1
      t.integer "user_id"
      t.timestamps
    end
  end
end
