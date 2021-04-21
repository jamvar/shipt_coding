class Order < ApplicationRecord
  validates :customer_id, :status, presence: true
  validates :status, inclusion: {in: ["ready", "on its way", "delivered"]}

  belongs_to :customer
  has_many :order_products
  has_many :products, through: :order_products

  def self.new_order_query(customer_id)
    ActiveRecord::Base.connection.execute(
      "
        INSERT INTO
          orders
        VALUES
          (
            (SELECT MAX(id)+1 FROM orders),
            'ready',
            #{customer_id},
            NOW(),
            NOW()
          )
        RETURNING
          id
      "
    )
  end

  def self.add_products_to_order_query(order_id, product_id, quantity)
    ActiveRecord::Base.connection.execute(
      "
        INSERT INTO
          order_products
        VALUES
          (
            (SELECT MAX(id)+1 FROM order_products),
            #{order_id},
            #{product_id},
            #{quantity},
            NOW()::timestamp,
            NOW()::timestamp
          )
      "
    )
  end
end
