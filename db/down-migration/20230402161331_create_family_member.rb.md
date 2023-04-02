class CreateFamilyMember < ActiveRecord::Migration[7.0]
  def change
    create_table :f_members do |t|
      t.string :name 
      t.string :role
      t.string :gender
      t.string :email 
      t.string :password
      t.integer :status , :default => 1
      t.integer :family_id
      t.timestamps
    end

    # create_table :family do |t|
    #   t.string :family_name 
    #   t.string :no_of_members
    #   t.text :user_id, array: true, default: []
    #   t.integer :status , :default => 1
    #   t.timestamps
    #  end
  end
end
