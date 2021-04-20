class OrderProduct < ApplicationRecord
  validates :order_id, :product_id, :quantity, presence: true
  validates :order_id, uniqueness: {scope: :product_id}

  belongs_to :order
  belongs_to :product
end
