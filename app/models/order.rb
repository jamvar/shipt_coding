class Order < ApplicationRecord
  validates :customer_id, :status, presence: true
  validates :status, inclusion: {in: ["ready", "on its way", "delivered"]}

  belongs_to :customer
  has_many :order_products
  has_many :products, through: :order_products
end
