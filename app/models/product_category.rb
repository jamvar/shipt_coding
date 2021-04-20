class ProductCategory < ApplicationRecord
  validates :product_id, :category_id, presence: true
  validates :product_id, uniqueness: {scope: :category_id}

  belongs_to :product
  belongs_to :category
end
