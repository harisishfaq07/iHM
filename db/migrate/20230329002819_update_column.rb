class UpdateColumn < ActiveRecord::Migration[7.0]
  def change
    change_column  :payments , :card_no , :string
    remove_column :payments , :stripeToken
  end
end
