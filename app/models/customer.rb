class Customer < ApplicationRecord
  validates :first_name, :last_name, presence: true

  has_many :orders
  has_many :ordered_products, through: :orders, source: :products

  def self.orders_by_customer_query(customer_id)
    ActiveRecord::Base.connection.execute(
      "
        SELECT
          o.id AS order_id,
          o.status AS order_status,
          o.created_at AS order_created_at
        FROM
          orders AS o
        WHERE
          customer_id=#{customer_id}
        ORDER BY
          o.created_at DESC
      "
    )
  end

  def self.customer_by_id_query(customer_id)
    ActiveRecord::Base.connection.execute(
      "
        SELECT
          id,
          first_name,
          last_name
        FROM
          customers
        WHERE
          id = #{customer_id}
      "
    )
  end
end
