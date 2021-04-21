class Product < ApplicationRecord
  validates :name, presence: true

  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :order_products

  def self.sold_by_date_range_query(start_date, stop_date, interval)
    ActiveRecord::Base.connection.execute(
      "
        SELECT
          DATE(DATE_TRUNC('#{interval}', op.created_at)) AS start_date,
          op.product_id AS product_id,
          p.name AS product_name,
          SUM(op.quantity) AS sales
        FROM
          (SELECT * FROM order_products WHERE created_at BETWEEN '#{start_date}' and '#{stop_date}') AS op
        INNER JOIN
          products AS p
        ON
          p.id = op.product_id
        GROUP BY
          DATE(DATE_TRUNC('#{interval}', op.created_at)),
          op.product_id,
          p.name
      "
    )
  end
end
