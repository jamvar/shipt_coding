class CreateProductCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_categories do |t|
      t.references :product, foreign_key: true, null: false, index: true
      t.references :category, foreign_key: true, null: false, index: true

      t.timestamps
    end
  end
end
