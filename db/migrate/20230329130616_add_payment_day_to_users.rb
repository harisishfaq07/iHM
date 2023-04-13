class AddPaymentDayToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :payment_date, :string, :default => ""
  end
end
