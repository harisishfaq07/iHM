class CreateStripeAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :stripe_accounts do |t|
      t.string :p_key
      t.string :s_key
      t.string :email
      t.integer :status , :default => 1

      t.timestamps
    end
  end
end
