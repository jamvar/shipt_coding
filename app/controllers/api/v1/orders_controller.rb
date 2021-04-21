module Api
  module V1
    class OrdersController < ApplicationController
      def new
        if params[:id].to_i == params[:customer_id]
          customer = customer_info(params[:id])

          if !validate_products(params[:products])
            render json: { message: 'One or more fields missing in request body' }, status: 400
          elsif customer
            @customer = { first_name: customer[:first_name], last_name: customer[:last_name] }
            @order = new_order(customer[:id], params[:products])
            render json: { message: 'Order Created' }, status: 201
          else
            render json: { message: 'No Customer Found' }, status: 404
          end
        else
          render json: { message: "'id' in url and 'customer_id' in request body must be same." }, status: 422
        end
      end

      private

      def validate_products(products)
        return false unless products

        products.each do |product|
          return false unless product.values_at(:id, :quantity).all?
        end
      end

      def new_order(customer_id, products)
        created_order_id = Order.new_order_query(customer_id).first['id']

        products.each do |p|
          Order.add_products_to_order_query(created_order_id, p['id'], p['quantity'])
        end
      end

      def customer_info(customer_id)
        customer = Customer.customer_by_id_query(customer_id).first

        if customer
          return {id: customer['id'], first_name: customer['first_name'], last_name: customer['last_name']}
        end
      end
    end
  end
end
