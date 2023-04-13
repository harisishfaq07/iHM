class CreateFamilyMember < ActiveRecord::Migration[7.0]
  def change
    create_table :family_members do |t|
      t.string "name"
      t.string "role"
      t.string "gender"
      t.string "email"
      t.string "password"
      t.integer "status", default: 1
      t.integer "family_id"
      t.timestamps
    end
  end
end
