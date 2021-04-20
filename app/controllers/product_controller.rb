class ProductController < ApplicationController
  def sold_by_date_range
    start_date = params[:start_date]
    stop_date = params[:stop_date]
    range = params[:range]

    list = Product.sold_by_date_range(start_date, stop_date, range)

    render json: list
  end
end
