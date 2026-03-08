class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.integer :stock, null: false, default: 0
      t.boolean :is_active, null: false, default: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end