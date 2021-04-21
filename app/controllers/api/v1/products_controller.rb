module Api
  module V1
    class ProductsController < ApplicationController
      def sales_by_date_range
        start_date = params[:start_date]
        end_date = params[:end_date]
        range = params[:range] || 'day'

        unless start_date.blank? || end_date.blank?
          product_sales = sold_by_date_range(start_date, end_date, range)

          render json: { "sales_by_#{range}": product_sales }, status: 200
        else
          render json: { message: 'one or more parameters missing' }, status: 500
        end
      end

      private

      def sold_by_date_range(start_date, end_date, range)
        sales = Product.sold_by_date_range_query(start_date, end_date, range)
        product_sales = {}

        sales.each do |sale|
          product_sales[sale['start_date']] ||= []

          product_sales[sale['start_date']] << {
            id: sale['product_id'],
            name: sale['product_name'],
            quantity_sold: sale['sales']
          }
        end

        product_sales
      end
    end
  end
end
