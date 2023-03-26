class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :package_no
      t.integer :card_no
      t.integer :cvc
      t.string :brand
      t.string :exp_month
      t.string :exp_year

      t.timestamps
    end
  end
end
