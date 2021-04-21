module Api
  module V1
    class CustomersController < ApplicationController
      def show_orders
        customer = customer_info(params[:id])

        if customer
          @customer = { first_name: customer[:first_name], last_name: customer[:last_name] }
          @orders = orders_by_customer(customer[:id])
          render json: { customer: @customer, orders: @orders }, status: 200
        else
          render json: { message: 'No Customer Found' }, status: 404
        end
      end

      private

      def orders_by_customer(customer_id)
        formatted_orders = []
        orders = Customer.orders_by_customer_query(customer_id)

        orders.each do |order|
          products_in_order = []
          formatted_orders << {
            id: order['order_id'],
            status: order['order_status'],
            date_ordered: order['order_created_at'],
            products: get_products_in_order(order['order_id'])
          }
        end

        formatted_orders
      end

      def get_products_in_order(order_id)
        order_products = Order.products_in_order_query(order_id)
        formatted_order_products = []

        order_products.each do |product|
          formatted_order_products << {
            id: product['product_id'],
            name: product['product_name'],
            quantity: product['quantity']
          }
        end

        formatted_order_products
      end

      def customer_info(customer_id)
        customer = Customer.customer_by_id_query(customer_id).first

        if customer
          return { id: customer['id'], first_name: customer['first_name'], last_name: customer['last_name'] }
        end
      end
    end
  end
end
