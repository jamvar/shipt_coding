class Customer < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :orders
  has_many :ordered_products, through: :orders, source: :products

  def self.orders_by_customer(id)
    ActiveRecord::Base.connection.select_all(
      "
        SELECT
          o.id AS order_id,
          o.status AS order_status,
          o.created_at AS order_created_at
        FROM
          orders AS o
        WHERE
          customer_id=#{id}
        ORDER BY
          o.created_at DESC
      "
    )
  end
end
