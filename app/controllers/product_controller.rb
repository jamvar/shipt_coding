class ProductController < ApplicationController
  def search
    start_date = params[:start_date]
    stop_date = params[:stop_date]
    range = params[:range]

    query_results = Product.sold_by_date_range_query(start_date, stop_date, range)
    byebug

    product_sales = sold_by_date_range(query_results, range)

    render json: product_sales
  end

  private

  def sold_by_date_range(sales, range)
    product_sales = {}

    sales.each do |sale|
      product_sales[sale["start_date"]] ||= []
      product_sales[sale["start_date"]] << {
        id: sale["product_id"],
        name: sale["product_name"],
        quantity_sold: sale["sales"]
      }
    end

    product_sales
  end
end
