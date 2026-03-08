class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :carts, :user_id, unique: true
  end
end
