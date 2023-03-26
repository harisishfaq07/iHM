class UpdateCol < ActiveRecord::Migration[7.0]
  def change
    change_column :payments, :card_no, :bigint
  end
end
