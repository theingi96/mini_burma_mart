class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :address, null: false, foreign_key: true
      t.integer :total_amount, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end