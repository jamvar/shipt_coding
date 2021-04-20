class CreateOrderProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :order_products do |t|
      t.references :order, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
      t.decimal :quantity, null: false

      t.timestamps
    end
  end
end
