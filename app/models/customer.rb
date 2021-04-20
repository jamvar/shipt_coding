class Customer < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :orders
  has_many :ordered_products, through: :orders, source: :products
end
