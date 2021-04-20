class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :status, null: false
      t.references :customer, foreign_key: true, null: false

      t.timestamps
    end
  end
end
